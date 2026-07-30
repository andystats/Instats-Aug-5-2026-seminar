# Module F reproducibility note

## What this archive reproduces

Module F starts with the fixed synthetic dataset in
`data/pneumonia_data.csv` and reproduces four risk-difference estimates:

1. crude association;
2. parametric g-computation;
3. Hajek inverse-probability weighting; and
4. targeted maximum likelihood estimation.

Module G archives the companion `simcausal` generator, its seed reconstruction,
and the model-implied benchmark for the frozen cohort. The fixed CSV is shared
byte-for-byte across Modules F and G (SHA-256
`1AAD6E3AA297183890FFD3FB4275F30BB416FFFBAC5CEDF461E76FBCE2928535` for the
committed LF file; a CRLF checkout, as on Windows with `autocrlf`, hashes to
`F020D8880321F3BF9E8D0AEB9319E1964408D00BB7657B677E02A0A27A5FD2BA`).

## Requirements and commands

Use a current R installation with `tmle`, `SuperLearner`, `glmnet`, and `ranger`.
From the repository root:

```sh
Rscript modules/F/code/pneumonia_navigator_tmle.R
```

The script writes:

- `outputs/pneumonia_results.csv`
- `outputs/pneumonia_diagnostics.csv`

To audit the DGP and frozen cohort, also install `simcausal` and run:

```sh
Rscript modules/G/simulate_pneumonia_data.R
```

The generator writes a disposable, Git-ignored regenerated CSV and the committed
`modules/G/outputs/pneumonia_generator_benchmark.csv`.

## Fixed-data checks

The archived dataset contains:

- 5,000 observations;
- 1,627 vaccinated and 3,373 unvaccinated observations;
- 334 pneumonia events;
- vaccinated risk `0.0719114935464044`; and
- unvaccinated risk `0.0643344203972725`.

The transparent estimators are:

| Analysis | Risk difference |
| --- | ---: |
| Crude association | `0.00757707314913197` |
| Parametric g-computation | `-0.0327629625657175` |
| Hajek IPW | `-0.0293576160195639` |

The generator reproduces every discrete value exactly in the checked Windows
environment. The maximum cross-platform age difference is below `5e-13` years.

## TMLE reporting convention

Modules F and G use the same learner library, seed, and three-fold settings:

```r
set.seed(2026)
sl_library <- c("SL.glm", "SL.glmnet", "SL.ranger")
# tmle(..., Q.SL.library = sl_library, g.SL.library = sl_library,
#      V.Q = 3, V.g = 3)
```

The reference Windows environment recorded R `4.5.2`, `tmle` `2.1.1`,
`SuperLearner` `2.0.29`, `glmnet` `4.1-10`, and `ranger` `0.17.0`. It produced:

```text
TMLE RD = -0.0305235555022229
95% CI  = -0.0460220828311262 to -0.0150250281733197
```

The course-facing convention is:

> TMLE risk difference: -3.0 percentage points (95% CI -4.6 to -1.5).

Use the versioned CSV when more digits are needed. Exact Super Learner output
can still change across software versions; a lockfile or container would be
required to promise bit-for-bit cross-environment replication.

## Propensity-score diagnostic

The range `0.0765242065485929` to `0.909121998932483` comes from the simple
fitted logistic treatment model

```text
A ~ age + priorPneumonia + priorVaccine
```

It is a practical-overlap diagnostic for this fitted dataset. It is not the
Super Learner nuisance estimate used inside TMLE and does not prove causal
positivity.

## Generator benchmark and remaining boundary

The archived generator computes the conditional counterfactual risks from the
known outcome model and averages them over the frozen cohort's covariates. The
result is `-0.040351190264`, or -4.04 percentage points. It is deterministic and
has no added outcome-simulation noise.

That value is a model-implied benchmark for this frozen synthetic cohort. It is
not an observed quantity, an exact superpopulation truth, or evidence about
pneumococcal vaccination in real patients.

The repository does not include a repeated estimator simulation, estimator-bias
or RMSE study, formal quantitative bias analysis, or proof that the identifying
assumptions would hold in real EHR data. The crude estimate uses observed
outcomes and is not an outcome-blind diagnostic.
