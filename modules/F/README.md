# Module F — Live Causal Navigator workshop

Module F is the workshop's central participant activity. The facilitator
operates the Causal Navigator while participants co-author an eight-step audit
and defend one entry in a decision log.

The example uses a fixed **synthetic teaching dataset** with 5,000 adults. Age
is centered at 65; the cohort is not restricted to adults aged 65 or older.
Nothing here is clinical evidence about pneumococcal-vaccine effectiveness.

## Participant start

1. Open `Pneumonia_Navigator_Student_Guide.pdf`.
2. Open <https://navigator.tao-rwd.com/> and choose the manual/no-login route.
3. Make each decision before the prepared entry is revealed.
4. At Step 8, export the completed Navigator record as Markdown.
5. Use `causal-roadmap-pneumonia-worked-example.md` only after the activity.

The participant deliverable is one Navigator entry they can accept, correct, or
reject, supported by evidence, a revision trigger, and its downstream
consequence.

## Canonical workshop materials

- `SegmentF_Live_Navigator.tex` — canonical 16-slide facilitator source
- `SegmentF_Live_Navigator.pdf` — compiled facilitator deck
- `Pneumonia_Navigator_Student_Guide.tex` — canonical participant workbook
- `Pneumonia_Navigator_Student_Guide.pdf` — compiled participant workbook
- `instats-preamble.tex` — shared Beamer styling
- `facilitator-live-demo.md` — 55-minute run of show and recovery plan
- `pneumonia-navigator-student-guide.md` — printable decision-log prompts
- `causal-roadmap-pneumonia-worked-example.md` — gated answer key
- `WORKSHOP_REVIEW.md` — conversion and workshop review
- `REPRODUCIBILITY.md` — technical audit and known limitations
- `pneumonia.dagitty.txt` — complete five-node, nine-edge DAGitty specification
- `data/pneumonia_data.csv` — fixed synthetic participant-level dataset
- `code/pneumonia_navigator_tmle.R` — crude, g-computation, IPW, and TMLE analysis
- `outputs/` — committed results and diagnostics
- `art/` — normalized PNG screenshots used by the Beamer sources

The two `.pptx` files are retained as source drafts from the original
PowerPoint development. The `.tex` files are now canonical; do not hand-edit the
compiled PDFs.

## Build the Beamer PDFs

From this directory:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error SegmentF_Live_Navigator.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error Pneumonia_Navigator_Student_Guide.tex
```

Both decks use a 16:9 layout and require a standard TeX Live installation with
the Metropolis Beamer theme. Screenshots in `art/` are already normalized as
PNG files.

## Reproduce the analysis

With R and the packages `tmle`, `SuperLearner`, `glmnet`, and `ranger`
installed:

```bash
Rscript code/pneumonia_navigator_tmle.R
```

The fixed-data results are:

| Analysis | 12-month risk difference |
| --- | ---: |
| Crude association | +0.76 percentage points |
| Parametric g-computation | -3.28 percentage points |
| Hájek IPW | -2.94 percentage points |
| TMLE | -3.0 percentage points (95% CI -4.6 to -1.5) |

TMLE changes slightly across package versions, so teaching materials use the
rounded result above and the script records package versions in the diagnostics
file.

## Interpretation limits

- The data generator and a truth calculation have not yet been archived.
  Therefore the materials do not claim a known finite-simulation truth or
  exchangeability “by construction.”
- The fixed dataset cannot certify exchangeability, consistency, positivity,
  or no interference. These assumptions are stipulated for the exercise and
  audited explicitly.
- The fitted parametric propensity-score range (0.0765–0.9091) is an overlap
  diagnostic, not proof of structural positivity.
- No repeated simulation, estimator bias, or RMSE study is included.
- The descriptive +3.0 percentage-point tipping point is not a formal E-value.
- Module G currently uses a different simulation. Treat the Module G handoff as
  planned work until its data and estimand are aligned with Module F.

For a motivating open-access discussion of causal roadmaps and target-trial
thinking, see [Dang and Balzer, DOI 10.1056/AIp2400727](https://doi.org/10.1056/AIp2400727).
The publisher PDF is not redistributed here.

[Return to the seminar overview](../../README.md)
