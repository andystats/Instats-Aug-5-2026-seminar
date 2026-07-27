#!/usr/bin/env Rscript

# Segment G live example: from the Navigator plan to a TMLE estimate
#
# Run from the folder containing this script:
#   Rscript pneumonia_tmle_example.R
#
# A = baseline pneumococcal vaccination
# Y = pneumonia hospitalization within 12 months
# W = age, prior pneumonia, prior vaccination
# Target = E[Y(1)] - E[Y(0)], the marginal 12-month risk difference

library(tmle)
library(SuperLearner)
library(glmnet)
library(ranger)

# Locate the companion files when the script is called from the repository root.
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

# 1. Load the same fixed synthetic cohort used by the Navigator example.
d <- read.csv(file.path(module_dir, "data", "pneumonia_data.csv"))
W <- d[c("age", "priorPneumonia", "priorVaccine")]
A <- d$A
Y <- d$Y

# 2. Start with the observed, unadjusted comparison.
risk_vaccinated <- mean(Y[A == 1])
risk_unvaccinated <- mean(Y[A == 0])
crude_rd <- risk_vaccinated - risk_unvaccinated

# 3. Fit transparent adjusted comparators.
outcome_model <- glm(
  Y ~ A + age + priorPneumonia + priorVaccine,
  family = binomial(),
  data = d
)

treatment_model <- glm(
  A ~ age + priorPneumonia + priorVaccine,
  family = binomial(),
  data = d
)

d_vaccinated <- transform(d, A = 1)
d_unvaccinated <- transform(d, A = 0)
Q1 <- predict(outcome_model, newdata = d_vaccinated, type = "response")
Q0 <- predict(outcome_model, newdata = d_unvaccinated, type = "response")
g <- predict(treatment_model, type = "response")

gcomp_rd <- mean(Q1 - Q0)

w1 <- A / g
w0 <- (1 - A) / (1 - g)
ipw_rd <- sum(w1 * Y) / sum(w1) - sum(w0 * Y) / sum(w0)

# 4. Estimate the same target with TMLE.
set.seed(2026)
learners <- c("SL.glm", "SL.glmnet", "SL.ranger")

fit <- tmle(
  Y = Y,
  A = A,
  W = W,
  Q.SL.library = learners,
  g.SL.library = learners,
  V.Q = 3,
  V.g = 3
)

tmle_rd <- fit$estimates$ATE$psi
tmle_ci <- fit$estimates$ATE$CI

# 5. Put the live results in one small table.
results <- data.frame(
  estimator = c("Crude", "G-computation", "Hajek IPW", "TMLE"),
  risk_difference_pp = 100 * c(
    crude_rd,
    gcomp_rd,
    ipw_rd,
    tmle_rd
  )
)

print(results, row.names = FALSE, digits = 3)
cat(sprintf(
  "\nTMLE 95%% CI: %+.2f to %+.2f percentage points\n",
  100 * tmle_ci[1],
  100 * tmle_ci[2]
))
cat(sprintf(
  "Estimated propensity range: %.3f to %.3f\n",
  min(g),
  max(g)
))
cat("\nSynthetic teaching data only - not clinical evidence.\n")
