#!/usr/bin/env Rscript

# Fixed-data analysis for the Module F pneumonia teaching example.
#
# This script begins with the archived synthetic CSV in data/. It does not
# generate that dataset, reconstruct a data-generating mechanism, or calculate
# a known causal truth. It estimates the crude association, parametric
# g-computation and Hajek IPW risk differences, and a TMLE risk difference.
#
# The Super Learner seed improves repeatability within a fixed software
# environment. Exact TMLE output can still change with R or package versions.
# The diagnostics file records those versions alongside the fitted-data checks.

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)

script_path <- if (length(file_arg)) {
  normalizePath(
    sub("^--file=", "", file_arg[[1]]),
    winslash = "/",
    mustWork = TRUE
  )
} else {
  candidates <- c(
    file.path("code", "pneumonia_navigator_tmle.R"),
    file.path("modules", "F", "code", "pneumonia_navigator_tmle.R"),
    file.path("Modules", "F", "code", "pneumonia_navigator_tmle.R")
  )
  matches <- candidates[file.exists(candidates)]
  if (!length(matches)) {
    stop(
      "Could not locate pneumonia_navigator_tmle.R. ",
      "Run this script with Rscript or set the working directory to Module F."
    )
  }
  normalizePath(matches[[1]], winslash = "/", mustWork = TRUE)
}

module_dir <- normalizePath(
  file.path(dirname(script_path), ".."),
  winslash = "/",
  mustWork = TRUE
)
data_path <- file.path(module_dir, "data", "pneumonia_data.csv")
output_dir <- file.path(module_dir, "outputs")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

required <- c("tmle", "SuperLearner", "glmnet", "ranger")
missing <- required[
  !vapply(required, requireNamespace, logical(1), quietly = TRUE)
]
if (length(missing)) {
  stop(
    "Missing required R packages: ",
    paste(missing, collapse = ", "),
    ". Install them before running this analysis."
  )
}

d <- read.csv(data_path)
expected <- c("age", "priorPneumonia", "priorVaccine", "A", "Y")
if (!all(expected %in% names(d))) {
  stop("Data must contain: ", paste(expected, collapse = ", "))
}
if (anyNA(d[expected])) {
  stop("The fixed teaching dataset is expected to be complete.")
}
if (!is.numeric(d[["age"]])) {
  stop("age must be numeric.")
}

binary <- c("priorPneumonia", "priorVaccine", "A", "Y")
valid_binary <- vapply(
  d[binary],
  function(x) all(x %in% c(0, 1)),
  logical(1)
)
if (!all(valid_binary)) {
  stop(
    "Binary variables must contain only 0 and 1: ",
    paste(binary[!valid_binary], collapse = ", ")
  )
}
if (length(unique(d[["A"]])) != 2L) {
  stop("Both treatment groups must be present.")
}

W <- d[c("age", "priorPneumonia", "priorVaccine")]
A <- d[["A"]]
Y <- d[["Y"]]
n <- nrow(d)

# Crude association.
crude_risk_1 <- mean(Y[A == 1])
crude_risk_0 <- mean(Y[A == 0])
crude_rd <- crude_risk_1 - crude_risk_0

# Transparent parametric comparators.
q_fit <- glm(
  Y ~ A + age + priorPneumonia + priorVaccine,
  family = binomial(),
  data = d
)
g_fit <- glm(
  A ~ age + priorPneumonia + priorVaccine,
  family = binomial(),
  data = d
)
g <- predict(g_fit, type = "response")

d1 <- transform(d, A = 1)
d0 <- transform(d, A = 0)
q1 <- predict(q_fit, newdata = d1, type = "response")
q0 <- predict(q_fit, newdata = d0, type = "response")
gcomp_rd <- mean(q1) - mean(q0)

# Hajek IPW standardizes each weighted mean by its own total weight.
w1 <- A / g
w0 <- (1 - A) / (1 - g)
ipw_risk_1 <- sum(w1 * Y) / sum(w1)
ipw_risk_0 <- sum(w0 * Y) / sum(w0)
ipw_rd <- ipw_risk_1 - ipw_risk_0

# The seed controls stochastic Super Learner fitting; it is not a data-
# generation seed. Package versions remain part of the computational result.
set.seed(2026)
sl_library <- c("SL.glm", "SL.glmnet", "SL.ranger")
fit <- tmle::tmle(
  Y = Y,
  A = A,
  W = W,
  Q.SL.library = sl_library,
  g.SL.library = sl_library
)

ate <- fit$estimates$ATE
tmle_rd <- unname(ate$psi)
tmle_se <- sqrt(unname(ate$var.psi))
tmle_lower <- unname(ate$CI[[1]])
tmle_upper <- unname(ate$CI[[2]])

results <- data.frame(
  analysis = c(
    "Crude association",
    "Parametric g-computation",
    "Hajek IPW",
    "TMLE"
  ),
  risk_difference = c(crude_rd, gcomp_rd, ipw_rd, tmle_rd),
  ci_lower = c(NA_real_, NA_real_, NA_real_, tmle_lower),
  ci_upper = c(NA_real_, NA_real_, NA_real_, tmle_upper),
  stringsAsFactors = FALSE
)

# propensity_min and propensity_max summarize predictions from the simple
# logistic g model above. They are practical-overlap diagnostics for this
# fitted dataset, not true treatment probabilities or proof of positivity.
diagnostics <- data.frame(
  metric = c(
    "N", "vaccinated_n", "unvaccinated_n", "events_n",
    "vaccinated_risk", "unvaccinated_risk",
    "propensity_min", "propensity_max",
    "tmle_standard_error", "tmle_p_value",
    "R_version", "tmle_version", "SuperLearner_version",
    "glmnet_version", "ranger_version"
  ),
  value = c(
    n, sum(A == 1), sum(A == 0), sum(Y == 1),
    crude_risk_1, crude_risk_0,
    min(g), max(g),
    tmle_se, unname(ate$pvalue),
    as.character(getRversion()),
    as.character(utils::packageVersion("tmle")),
    as.character(utils::packageVersion("SuperLearner")),
    as.character(utils::packageVersion("glmnet")),
    as.character(utils::packageVersion("ranger"))
  ),
  stringsAsFactors = FALSE
)

write.csv(
  results,
  file.path(output_dir, "pneumonia_results.csv"),
  row.names = FALSE
)
write.csv(
  diagnostics,
  file.path(output_dir, "pneumonia_diagnostics.csv"),
  row.names = FALSE
)

cat("\nPneumonia vaccine fixed-data teaching analysis\n")
cat("---------------------------------------------\n")
cat(sprintf("Crude RD: %+.6f\n", crude_rd))
cat(sprintf("G-computation RD: %+.6f\n", gcomp_rd))
cat(sprintf("Hajek IPW RD: %+.6f\n", ipw_rd))
cat(sprintf(
  "TMLE RD: %+.6f (95%% CI %+.6f to %+.6f)\n",
  tmle_rd, tmle_lower, tmle_upper
))
cat("\nTMLE precision is software-version sensitive; see diagnostics.\n")
cat("For teaching slides, report -3.0 percentage points ")
cat("(95% CI -4.6 to -1.5).\n")
cat("The propensity range is a fitted parametric diagnostic only.\n")
cat("\nWrote:\n")
cat(file.path(output_dir, "pneumonia_results.csv"), "\n")
cat(file.path(output_dir, "pneumonia_diagnostics.csv"), "\n")
