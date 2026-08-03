# Module G - TMLE

Module G carries the study plan created in the Causal Navigator into estimation.
The live and technical versions use the same fixed synthetic pneumonia cohort,
treatment, outcome, adjustment set, estimand, learner library, and runtime
settings as Module F.

The materials are teaching examples, not clinical evidence about pneumococcal
vaccination.

## Start with the live version

- [Live Beamer deck](SegmentG_TMLE.pdf) - 15-slide workshop presentation
- [Live Beamer source](SegmentG_TMLE.tex)
- [Streamlined R example](pneumonia_tmle_example.R)

From the repository root:

```sh
Rscript modules/G/pneumonia_tmle_example.R
```

The live script reports crude association, parametric g-computation, Hajek IPW,
and TMLE on one risk-difference scale.

## Optional technical supplement

- [Technical supplement](SegmentG_TMLE_Technical_Supplement.pdf) - 32 slides
- [Technical Beamer source](SegmentG_TMLE_Technical_Supplement.tex)
- [Comprehensive R example](pneumonia_tmle_technical.R)

The supplement opens the initial outcome regression, treatment mechanism,
clever covariate, targeting update, plug-in contrast, efficient influence
function, uncertainty calculation, and package implementation.

```sh
Rscript modules/G/pneumonia_tmle_technical.R
```

## Optional live demonstration: the analytics handoff

- [Facilitator guide](facilitator-analytics-handoff.md) - 10 to 12 minutes
- [Data dictionary](data/pneumonia_dictionary.csv) - column roles for the tool
- [Run-at-home kit](https://navigator.tao-rwd.com/kits/pneumonia-tmle/pneumonia-tmle.zip)

The demonstration shows the join between Module F and Module G: the Navigator
writes the analysis specification from a data dictionary alone, estimation runs
locally, and only summary output returns to the study record. The kit contains
the same cohort, a dictionary, and a script reporting the same four estimators.

## Synthetic data and provenance

- [Frozen teaching cohort](data/pneumonia_data.csv)
- [Data dictionary](data/pneumonia_dictionary.csv)
- [Standalone `simcausal` generator](simulate_pneumonia_data.R)
- [Model-implied benchmark](outputs/pneumonia_generator_benchmark.csv)

Run the generator from the repository root:

```sh
Rscript modules/G/simulate_pneumonia_data.R
```

It writes `data/pneumonia_data_regenerated.csv` without overwriting the frozen
cohort. That regenerated file is ignored by Git. The RNG advance reproduces the
state of the original knitted notebook, in which DAG construction and rendering
occurred after the seed was set.

The generator also calculates a deterministic model-implied risk difference of
-4.04 percentage points for the frozen cohort's covariate distribution. This is
a teaching-DGP benchmark, not an observed quantity, an exact superpopulation
truth, or evidence about a real study.

## Reference results

| Analysis | 12-month risk difference |
| --- | ---: |
| Crude association | +0.76 percentage points |
| Parametric g-computation | -3.28 percentage points |
| Hajek IPW | -2.94 percentage points |
| TMLE | -3.05 percentage points (95% CI -4.60 to -1.50) |
| Model-implied benchmark for the frozen cohort | -4.04 percentage points |

The comprehensive script writes versioned results, diagnostics, session
information, and the two figures used by the decks to `outputs/` and `art/`.

## R requirements

Use a current R installation with these packages:

```r
install.packages(c(
  "tmle", "SuperLearner", "glmnet", "ranger", "ggplot2", "simcausal"
))
```

The committed `outputs/session_info.txt` records the environment used for the
reference technical run. Exact Super Learner results can still vary across
software versions.

## Build the Beamer PDFs

From `modules/G`:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error SegmentG_TMLE.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error SegmentG_TMLE_Technical_Supplement.tex
```

Both decks use a 16:9 Beamer layout and include a source note on every slide.

[Return to the seminar overview](../../README.md)
