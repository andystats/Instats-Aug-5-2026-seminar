# Module F reproducibility note

## What this archive reproduces

The Module F analysis starts with the fixed synthetic dataset in
`data/pneumonia_data.csv`. The analysis script reproduces four risk-difference
estimates from that file:

1. the crude association;
2. parametric g-computation;
3. Hajek inverse-probability weighting (IPW); and
4. targeted maximum likelihood estimation (TMLE).

This is fixed-data analysis reproducibility. The archive does not currently
reproduce the data-generating process or a known causal truth.

## Requirements

Use a current R installation with these packages:

- `tmle`
- `SuperLearner`
- `glmnet`
- `ranger`

Install them from R if needed:

```r
install.packages(c("tmle", "SuperLearner", "glmnet", "ranger"))
```

From the Module F directory, run:

```sh
Rscript code/pneumonia_navigator_tmle.R
```

The script writes:

- `outputs/pneumonia_results.csv`
- `outputs/pneumonia_diagnostics.csv`

The diagnostics file records the R and package versions used for each run.

## Fixed-data checks

The archived dataset contains:

- 5,000 observations;
- 1,627 vaccinated and 3,373 unvaccinated observations;
- 334 pneumonia events;
- vaccinated risk `0.0719114935464044`; and
- unvaccinated risk `0.0643344203972725`.

The archived reference output and an independent rerun agreed to reportable
precision:

| Analysis | Archived reference | Independent rerun |
| --- | ---: | ---: |
| Crude association | `0.00757707314913197` | `0.00757707314913197` |
| Parametric g-computation | `-0.0327629625657175` | `-0.0327629625657177` |
| Hajek IPW | `-0.0293576160195639` | `-0.0293576160195641` |

The last-digit differences for g-computation and IPW are ordinary
floating-point differences, approximately `2e-16`.

## TMLE reporting convention

TMLE uses a stochastic Super Learner fit. `set.seed(2026)` makes repeated runs
deterministic within each checked environment, but exact output remains
sensitive to software versions.

The archived reference environment recorded:

- R `4.5.2`
- `tmle` `2.1.1`
- `SuperLearner` `2.0.29`
- `glmnet` `4.1.10`
- `ranger` `0.17.0`

It produced:

```text
TMLE RD = -0.0303863678615073
95% CI  = -0.0461121121455724 to -0.0146606235774421
```

An independent environment using R `4.5.0`, `tmle` `2.0.1.1`,
`SuperLearner` `2.0.29`, `glmnet` `4.1.8`, and `ranger` `0.17.0` produced:

```text
TMLE RD = -0.0302641913600365
95% CI  = -0.0459431740023533 to -0.0145852087177196
```

Both support the same workshop-level reporting convention:

> TMLE risk difference: -3.0 percentage points (95% CI -4.6 to -1.5).

Use the versioned CSV output when more digits are needed. A dependency lockfile
would be required to promise exact cross-environment TMLE replication.

## Propensity-score diagnostic

The reported range `0.0765242065485929` to `0.909121998932483` comes from the
simple fitted logistic treatment model

```text
A ~ age + priorPneumonia + priorVaccine
```

It is a practical-overlap diagnostic for this fitted dataset. It is not the
true treatment mechanism, it is not the Super Learner nuisance estimate used
inside TMLE, and it does not prove the causal positivity assumption.

## Current reproducibility boundary

The following items are not currently archived and must not be described as
reproduced:

- the code and seed that generated `data/pneumonia_data.csv`;
- counterfactual outcomes or an intervention simulation;
- a known causal risk difference or causal risk ratio;
- an estimator-bias or root-mean-square-error simulation; and
- a formal quantitative bias analysis.

No repeated estimator simulation is included, so the workshop should not claim
that bias or RMSE was computed. The crude estimate uses observed outcomes and
therefore is not an "outcome-blind" diagnostic.

Until a data generator and truth calculation are archived, the materials may
describe the dataset as synthetic and report the fixed-data estimates above,
but should not present a numerical causal truth as independently reproducible.
