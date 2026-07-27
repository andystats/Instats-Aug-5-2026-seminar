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
- [Live run of show and recovery plan](facilitator-live.md)

From the repository root:

```sh
Rscript modules/G/pneumonia_tmle_example.R
```

The live script reports crude association, parametric g-computation, IPTW (normalized/Hájek form),
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

## Synthetic data and provenance

- [Frozen teaching cohort](data/pneumonia_data.csv)
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
| IPTW | -2.94 percentage points |
| TMLE | about -3.0 percentage points (95% CI about -4.6 to -1.5) |
| Model-implied benchmark for the frozen cohort | -4.04 percentage points |

The participant-facing live result uses a stable one-decimal convention. The
archived CSV retains full precision for the recorded reference environment.

The overlap figure shows the parametric-GLM propensity-score comparator
diagnostic (0.077 to 0.909). The archived TMLE Super Learner (g) range is
0.092 to 0.894; both are fitted-data diagnostics, not proof of positivity.

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
