#!/usr/bin/env Rscript

# Segment G companion: reproduce the fixed synthetic pneumonia cohort
#
# Run from the folder containing this script:
#   Rscript simulate_pneumonia_data.R
#
# The script writes data/pneumonia_data_regenerated.csv so the frozen teaching
# file is not overwritten. It then checks that every regenerated value matches
# data/pneumonia_data.csv.

library(simcausal)

n <- 5000

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
data_dir <- file.path(module_dir, "data")
output_dir <- file.path(module_dir, "outputs")
dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Outcome model: vaccination is protective, while age and prior pneumonia
# increase the probability of pneumonia hospitalization.
beta_0 <- -3.00
beta_A <- -0.80
beta_age <- 0.25
beta_prevpn <- 1.60
beta_priorvax <- -0.15

# Treatment model: people with higher baseline risk are more likely to receive
# the vaccine, creating confounding by indication in the observational data.
alpha_0 <- -1.40
alpha_age <- 0.25
alpha_prevpn <- 1.40
alpha_priorvax <- 1.20

# Baseline history models.
gamma_prevpn_0 <- -1.60
gamma_prevpn_age <- 0.06
gamma_priorvax_0 <- -1.20
gamma_priorvax_age <- 0.08

D <- DAG.empty() +
  node("age", distr = "rnorm", mean = 65, sd = 12) +
  node(
    "priorPneumonia",
    distr = "rbinom",
    size = 1,
    prob = plogis(gamma_prevpn_0 + gamma_prevpn_age * (age - 65))
  ) +
  node(
    "priorVaccine",
    distr = "rbinom",
    size = 1,
    prob = plogis(gamma_priorvax_0 + gamma_priorvax_age * (age - 65))
  ) +
  node(
    "A",
    distr = "rbinom",
    size = 1,
    prob = plogis(
      alpha_0 +
        alpha_age * ((age - 65) / 10) +
        alpha_prevpn * priorPneumonia +
        alpha_priorvax * priorVaccine
    )
  ) +
  node(
    "Y",
    distr = "rbinom",
    size = 1,
    prob = plogis(
      beta_0 +
        beta_A * A +
        beta_age * ((age - 65) / 10) +
        beta_prevpn * priorPneumonia +
        beta_priorvax * priorVaccine
    )
  )

D <- set.DAG(D)

# Reproduce the RNG state of the original knitted Session 1 notebook. The
# notebook set the seed before DAG construction and plotting; those steps
# consumed 5,070 draws before sim() ran. The fixed CSV remains the authority.
set.seed(2026)
invisible(runif(5070))
simulated <- sim(D, n = n)
pneumonia_data <- data.frame(
  ID = seq_len(n),
  age = simulated$age,
  priorPneumonia = simulated$priorPneumonia,
  priorVaccine = simulated$priorVaccine,
  A = simulated$A,
  Y = simulated$Y
)

regenerated_path <- file.path(data_dir, "pneumonia_data_regenerated.csv")
write.csv(pneumonia_data, regenerated_path, row.names = FALSE)

frozen_path <- file.path(data_dir, "pneumonia_data.csv")
benchmark_data <- pneumonia_data
if (file.exists(frozen_path)) {
  frozen <- read.csv(frozen_path)
  same_structure <- identical(names(pneumonia_data), names(frozen)) &&
    nrow(pneumonia_data) == nrow(frozen) &&
    identical(pneumonia_data$ID, frozen$ID)
  same_discrete_values <- identical(
    pneumonia_data[c("priorPneumonia", "priorVaccine", "A", "Y")],
    frozen[c("priorPneumonia", "priorVaccine", "A", "Y")]
  )
  age_difference <- max(abs(pneumonia_data$age - frozen$age))
  if (!same_structure || !same_discrete_values || age_difference >= 1e-12) {
    stop("Regenerated values do not match the frozen teaching cohort.")
  }
  benchmark_data <- frozen
  cat("Row-for-row match with", frozen_path, "\n")
  cat(sprintf("Maximum cross-platform age difference: %.3e years\n", age_difference))
}

# Calculate the model-implied target for the frozen covariate distribution.
# This averages counterfactual risks, so it has no additional Monte Carlo noise.
lp0 <- beta_0 +
  beta_age * ((benchmark_data$age - 65) / 10) +
  beta_prevpn * benchmark_data$priorPneumonia +
  beta_priorvax * benchmark_data$priorVaccine
benchmark_rd <- mean(plogis(lp0 + beta_A) - plogis(lp0))

benchmark_output <- data.frame(
  benchmark = "Model-implied risk difference for the frozen cohort",
  risk_difference = benchmark_rd,
  risk_difference_pp = 100 * benchmark_rd
)
benchmark_path <- file.path(
  output_dir,
  "pneumonia_generator_benchmark.csv"
)
write.csv(benchmark_output, benchmark_path, row.names = FALSE)

cat("Wrote:", regenerated_path, "\n")
cat("Wrote:", benchmark_path, "\n")
cat(sprintf(
  "Model-implied fixed-cohort benchmark: %+.2f percentage points\n",
  100 * benchmark_rd
))
cat("simcausal version:", as.character(packageVersion("simcausal")), "\n")
