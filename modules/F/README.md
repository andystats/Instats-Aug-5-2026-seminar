# Module F - Live Causal Navigator workshop

Module F is the workshop's central participant activity. The facilitator
operates the Causal Navigator while participants co-author an eight-step audit
and defend one entry in a decision log.

The example uses a fixed synthetic teaching dataset with 5,000 adults. Age is
centered at 65; the cohort is not restricted to adults aged 65 or older. Nothing
here is clinical evidence about pneumococcal-vaccine effectiveness.

## Participant start

1. Open [the participant workbook](Pneumonia_Navigator_Student_Guide.pdf).
2. Open <https://navigator.tao-rwd.com/> and choose the manual/no-login route.
3. Make each decision before the prepared entry is revealed.
4. At Step 8, export the completed Navigator record as Markdown.
5. Use the [completed worked example](causal-roadmap-pneumonia-worked-example.md)
   only after the activity.
6. Continue to [Module G](../G/) for the aligned estimation walkthrough.

The participant deliverable is one Navigator entry they can accept, correct, or
reject, supported by evidence, a revision trigger, and its downstream
consequence.

## Canonical workshop materials

- `SegmentF_Live_Navigator.tex` - canonical 16-slide facilitator source
- `SegmentF_Live_Navigator.pdf` - compiled facilitator deck
- `Pneumonia_Navigator_Student_Guide.tex` - canonical participant workbook
- `Pneumonia_Navigator_Student_Guide.pdf` - compiled participant workbook
- `instats-preamble.tex` - shared Beamer styling
- `facilitator-live-demo.md` - 55-minute run of show and recovery plan
- `pneumonia-navigator-student-guide.md` - printable decision-log prompts
- `causal-roadmap-pneumonia-worked-example.md` - gated answer key
- `WORKSHOP_REVIEW.md` - conversion and workshop review
- `REPRODUCIBILITY.md` - technical audit and reproducibility boundary
- `pneumonia.dagitty.txt` - complete five-node, nine-edge DAGitty specification
- `data/pneumonia_data.csv` - fixed synthetic participant-level dataset
- `code/pneumonia_navigator_tmle.R` - aligned crude, g-computation, IPW, and TMLE analysis
- `outputs/` - committed results and diagnostics
- `art/` - normalized Navigator screenshots used by the Beamer sources

The data-generating script and model-implied benchmark are archived with the
[Module G technical materials](../G/). The two `.pptx` files here are retained
as source drafts from the original PowerPoint development. The `.tex` files are
canonical; do not hand-edit the compiled PDFs.

## Build the Beamer PDFs

From this directory:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error SegmentF_Live_Navigator.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error Pneumonia_Navigator_Student_Guide.tex
```

Both decks use a 16:9 layout and require a standard TeX installation with the
Metropolis Beamer theme. Screenshots in `art/` are normalized PNG files.

## Reproduce the analysis

With R and the packages `tmle`, `SuperLearner`, `glmnet`, and `ranger`
installed, run from the repository root:

```sh
Rscript modules/F/code/pneumonia_navigator_tmle.R
```

Module F and Module G use the same three-fold Super Learner settings. The fixed
reference results are:

| Analysis | 12-month risk difference |
| --- | ---: |
| Crude association | +0.76 percentage points |
| Parametric g-computation | -3.28 percentage points |
| Hajek IPW | -2.94 percentage points |
| TMLE | -3.05 percentage points (95% CI -4.60 to -1.50) |

Teaching slides round the TMLE result to -3.0 percentage points with a 95%
confidence interval of -4.6 to -1.5. Exact output can still vary slightly across
software versions; the diagnostics file records the checked environment.

## Interpretation limits

- The known teaching generator uses age, prior pneumonia, and prior vaccination
  as the baseline common causes of vaccination and hospitalization. That makes
  the synthetic construction auditable; it does not establish exchangeability
  for a real observational study.
- The fixed observed dataset alone cannot certify exchangeability, consistency,
  positivity, or no interference. The workshop audits each assumption explicitly.
- The fitted parametric propensity-score range (0.0765-0.9091) is an overlap
  diagnostic, not proof of structural positivity.
- Module G reports a -4.04-point model-implied benchmark for the frozen cohort.
  It is not an observed quantity, an exact superpopulation truth, or clinical evidence.
- No repeated estimator simulation, bias study, RMSE study, or formal
  quantitative bias analysis is included.
- The descriptive +3.0-point tipping calculation is not a formal E-value.

For target-trial and roadmap background, see Dang and Balzer,
[DOI 10.1097/EDE.0000000000001637](https://doi.org/10.1097/EDE.0000000000001637).
For the human-in-the-loop causal copilot perspective, see Petersen et al.,
[DOI 10.1056/AIp2400727](https://doi.org/10.1056/AIp2400727).

[Return to the seminar overview](../../README.md)
