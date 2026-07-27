#!/usr/bin/env Rscript

# Segment G technical supplement
#
# This script exposes the main TMLE components that the live example leaves
# inside tmle(): initial Q, treatment mechanism g, clever covariate, targeting
# coefficient, updated predictions, plug-in estimate, and influence-function
# standard error. Run from the folder containing this script.

library(SuperLearner)
library(glmnet)
library(ranger)
library(tmle)
library(ggplot2)

# Locate inputs and outputs when called from the repository root.
script_args <- commandArgs(trailingOnly = FALSE)
script_file <- grep("^--file=", script_args, value = TRUE)
module_dir <- if (length(script_file)) {
  dirname(normalizePath(
    sub("^--file=", "", script_file[[1]]),
    winslash = "/",
    mustWork = TRUE
  ))
} else {
  normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}
output_dir <- file.path(module_dir, "outputs")
art_dir <- file.path(module_dir, "art")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(art_dir, recursive = TRUE, showWarnings = FALSE)

d <- read.csv(file.path(module_dir, "data", "pneumonia_data.csv"))
benchmark_record <- read.csv(
  file.path(output_dir, "pneumonia_generator_benchmark.csv")
)
generator_benchmark_rd <- benchmark_record$risk_difference[[1]]
W <- d[c("age", "priorPneumonia", "priorVaccine")]
A <- d$A
Y <- d$Y
n <- nrow(d)

learners <- c("SL.glm", "SL.glmnet", "SL.ranger")
bound <- function(x, lower = 0.025, upper = 0.975) {
  pmin(pmax(x, lower), upper)
}

# ---------------------------------------------------------------------------
# 1. Initial outcome regression Q(A,W)
# ---------------------------------------------------------------------------

set.seed(2026)
Q_fit <- SuperLearner(
  Y = Y,
  X = data.frame(A = A, W),
  family = binomial(),
  SL.library = learners,
  cvControl = list(V = 3L)
)


X_vaccinated <- data.frame(A = 1, W)
X_unvaccinated <- data.frame(A = 0, W)

QAW <- bound(Q_fit$SL.predict, 1e-6, 1 - 1e-6)
Q1 <- bound(predict(Q_fit, newdata = X_vaccinated)$pred, 1e-6, 1 - 1e-6)
Q0 <- bound(predict(Q_fit, newdata = X_unvaccinated)$pred, 1e-6, 1 - 1e-6)
gcomp_rd <- mean(Q1 - Q0)

# ---------------------------------------------------------------------------
# 2. Treatment mechanism g(W) and overlap
# ---------------------------------------------------------------------------

set.seed(2026)
g_fit <- SuperLearner(
  Y = A,
  X = W,
  family = binomial(),
  SL.library = learners,
  cvControl = list(V = 3L)
)


g_raw <- g_fit$SL.predict
g <- bound(g_raw)
H <- A / g - (1 - A) / (1 - g)

# ---------------------------------------------------------------------------
# 3. One-dimensional targeting update
# ---------------------------------------------------------------------------

fluctuation <- glm(
  Y ~ -1 + H + offset(qlogis(QAW)),
  family = binomial()
)
epsilon <- unname(coef(fluctuation)[["H"]])

H1 <- 1 / g
H0 <- -1 / (1 - g)
Q1_star <- plogis(qlogis(Q1) + epsilon * H1)
Q0_star <- plogis(qlogis(Q0) + epsilon * H0)
QAW_star <- plogis(qlogis(QAW) + epsilon * H)

manual_tmle_rd <- mean(Q1_star - Q0_star)

# ---------------------------------------------------------------------------
# 4. Efficient influence function and Wald interval
# ---------------------------------------------------------------------------

eif <- H * (Y - QAW_star) +
  (Q1_star - Q0_star) -
  manual_tmle_rd

manual_se <- sd(eif) / sqrt(n)
manual_ci <- manual_tmle_rd + qnorm(c(0.025, 0.975)) * manual_se

# ---------------------------------------------------------------------------
# 5. Compare with the one-call implementation used in the live example
# ---------------------------------------------------------------------------

set.seed(2026)
package_fit <- tmle(
  Y = Y,
  A = A,
  W = W,
  Q.SL.library = learners,
  g.SL.library = learners,
  V.Q = 3,
  V.g = 3
)

package_ate <- package_fit$estimates$ATE
package_tmle_rd <- unname(package_ate$psi)
package_se <- sqrt(unname(package_ate$var.psi))
package_ci <- unname(package_ate$CI)

crude_rd <- mean(Y[A == 1]) - mean(Y[A == 0])

parametric_Q <- glm(
  Y ~ A + age + priorPneumonia + priorVaccine,
  family = binomial(),
  data = d
)
parametric_g <- glm(
  A ~ age + priorPneumonia + priorVaccine,
  family = binomial(),
  data = d
)

parametric_Q1 <- predict(
  parametric_Q,
  newdata = transform(d, A = 1),
  type = "response"
)
parametric_Q0 <- predict(
  parametric_Q,
  newdata = transform(d, A = 0),
  type = "response"
)
parametric_g_hat <- predict(parametric_g, type = "response")
w1 <- A / parametric_g_hat
w0 <- (1 - A) / (1 - parametric_g_hat)

parametric_gcomp_rd <- mean(parametric_Q1 - parametric_Q0)
ipw_rd <- sum(w1 * Y) / sum(w1) - sum(w0 * Y) / sum(w0)

results <- data.frame(
  estimator = c(
    "Crude association",
    "Parametric g-computation",
    "Hajek IPW",
    "Manual TMLE decomposition",
    "tmle package",
    "Model-implied DGP benchmark"
  ),
  risk_difference = c(
    crude_rd,
    parametric_gcomp_rd,
    ipw_rd,
    manual_tmle_rd,
    package_tmle_rd,
    generator_benchmark_rd
  ),
  ci_lower = c(NA, NA, NA, manual_ci[1], package_ci[1], NA),
  ci_upper = c(NA, NA, NA, manual_ci[2], package_ci[2], NA)
)

diagnostics <- data.frame(
  metric = c(
    "N",
    "vaccinated_n",
    "events_n",
    "raw_propensity_min",
    "raw_propensity_max",
    "share_raw_propensity_outside_0.025_0.975",
    "targeting_epsilon",
    "mean_eif",
    "initial_sl_gcomp_rd",
    "generator_benchmark_rd",
    "manual_tmle_se",
    "package_tmle_se"
  ),
  value = c(
    n,
    sum(A == 1),
    sum(Y == 1),
    min(g_raw),
    max(g_raw),
    mean(g_raw < 0.025 | g_raw > 0.975),
    epsilon,
    mean(eif),
    gcomp_rd,
    generator_benchmark_rd,
    manual_se,
    package_se
  )
)

write.csv(
  results,
  file.path(output_dir, "pneumonia_tmle_technical_results.csv"),
  row.names = FALSE
)
write.csv(
  diagnostics,
  file.path(output_dir, "pneumonia_tmle_technical_diagnostics.csv"),
  row.names = FALSE
)
session_info_lines <- sub("[[:space:]]+$", "", capture.output(sessionInfo()))
writeLines(
  session_info_lines,
  con = file.path(output_dir, "session_info.txt"),
  useBytes = TRUE
)

# Figures used by both decks.
plot_results <- transform(
  results[results$estimator %in% c(
    "Crude association",
    "Parametric g-computation",
    "Hajek IPW",
    "tmle package"
  ), ],
  estimator = factor(
    estimator,
    levels = rev(c(
      "Crude association",
      "Parametric g-computation",
      "Hajek IPW",
      "tmle package"
    ))
  ),
  estimate_pp = 100 * risk_difference,
  lower_pp = 100 * ci_lower,
  upper_pp = 100 * ci_upper
)

p_estimators <- ggplot(
  plot_results,
  aes(y = estimator, x = estimate_pp)
) +
  geom_vline(xintercept = 0, color = "grey70", linewidth = 0.7) +
  geom_vline(
    xintercept = 100 * generator_benchmark_rd,
    color = "#23373B",
    linewidth = 0.8,
    linetype = "dashed"
  ) +
  geom_segment(
    data = subset(plot_results, !is.na(lower_pp)),
    aes(x = lower_pp, xend = upper_pp, yend = estimator),
    color = "#23373B",
    linewidth = 1.2
  ) +
  geom_point(
    aes(color = estimator == "Crude association"),
    size = 4
  ) +
  scale_color_manual(
    values = c(`TRUE` = "#C4473A", `FALSE` = "#4A9EFF"),
    guide = "none"
  ) +
  scale_x_continuous(breaks = seq(-5, 2, by = 1), limits = c(-5.5, 2)) +
  labs(
    x = "Estimated 12-month risk difference (percentage points)",
    y = NULL,
    caption = sprintf(
      "Dashed line: %.2f-point model-implied benchmark for the frozen cohort",
      100 * generator_benchmark_rd
    )
  ) +
  theme_minimal(base_size = 16) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(color = "#23373B"),
    axis.title.x = element_text(color = "#23373B"),
    plot.caption = element_text(color = "grey40", hjust = 0)
  )

ggsave(
  file.path(art_dir, "estimator_comparison.png"),
  p_estimators,
  width = 10,
  height = 5.5,
  dpi = 180,
  bg = "white"
)

overlap <- data.frame(
  propensity = parametric_g_hat,
  arm = factor(
    A,
    levels = c(0, 1),
    labels = c("Unvaccinated", "Vaccinated")
  )
)

p_overlap <- ggplot(
  overlap,
  aes(x = propensity, fill = arm, color = arm)
) +
  geom_density(alpha = 0.25, linewidth = 1) +
  geom_vline(
    xintercept = c(0.05, 0.95),
    color = "grey45",
    linetype = "dashed"
  ) +
  scale_fill_manual(
    values = c(Unvaccinated = "grey60", Vaccinated = "#4A9EFF")
  ) +
  scale_color_manual(
    values = c(Unvaccinated = "grey40", Vaccinated = "#2878C8")
  ) +
  scale_x_continuous(breaks = seq(0, 1, by = 0.2), limits = c(0, 1)) +
  labs(
    x = "Estimated P(vaccinated | W)",
    y = "Density",
    fill = NULL,
    color = NULL
  ) +
  theme_minimal(base_size = 16) +
  theme(
    legend.position = "top",
    panel.grid.minor = element_blank(),
    axis.text = element_text(color = "#23373B"),
    axis.title = element_text(color = "#23373B")
  )

ggsave(
  file.path(art_dir, "propensity_overlap.png"),
  p_overlap,
  width = 9.5,
  height = 5.2,
  dpi = 180,
  bg = "white"
)

cat("\nSegment G technical decomposition\n")
cat("=================================\n")
print(results, row.names = FALSE, digits = 4)
cat(sprintf("\nTargeting epsilon: %.6f\n", epsilon))
cat(sprintf("Mean efficient influence function: %.3e\n", mean(eif)))
cat(sprintf(
  "Raw propensity range: %.3f to %.3f\n",
  min(g_raw),
  max(g_raw)
))
cat("\nSynthetic teaching data only - not clinical evidence.\n")
