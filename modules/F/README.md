# Module F — Live Navigator workshop

## Purpose

Module F is the standalone workshop that follows Module D's causal-roadmap
introduction. It gives a very brief orientation to the current Causal Navigator,
then carries the pneumonia-vaccine example through all eight steps using the
no-login manual route.

The example uses synthetic teaching data only. The cohort contains 5,000 adults
whose age is centered at 65; it is not restricted to people aged 65 or older.
Nothing in these materials is clinical evidence about vaccine effectiveness.

## Course-ready materials

- `SegmentF_Live_Navigator.pptx` — editable 16-slide facilitator deck
- `SegmentF_Live_Navigator.pdf` — course-site PDF of the facilitator deck
- `Pneumonia_Navigator_Student_Guide.pptx` — editable 10-slide participant deck
- `Pneumonia_Navigator_Student_Guide.pdf` — course-site participant PDF
- `causal-roadmap-pneumonia-worked-example.md` — completed eight-step Navigator record
- `pneumonia-navigator-student-guide.md` — concise written participant handout
- `facilitator-live-demo.md` — 55-minute run-of-show, paste order, and recovery plan
- `pneumonia.dagitty.txt` — complete five-node, nine-edge DAGitty specification
- `data/pneumonia_data.csv` — fixed synthetic workshop dataset
- `code/pneumonia_navigator_tmle.R` — reproducible crude, g-computation, IPW, and TMLE analysis
- `outputs/pneumonia_results.csv` — analysis results used in the decks
- `outputs/pneumonia_diagnostics.csv` — counts, overlap diagnostics, and package versions
- `art/` — tactical screenshots captured from the production Navigator on 2026-07-26

## Live route

Open <https://navigator.tao-rwd.com/>, choose **Causal Navigator**, and use the
manual/no-login path. The facilitator guide contains the exact paste order. The
completed Markdown record is the answer key and a fallback if the live site is
unavailable.

## Reproduce the worked result

From this directory, run:

```powershell
& 'C:\Program Files\R\R-4.5.2\bin\Rscript.exe' 'code/pneumonia_navigator_tmle.R'
```

The seeded TMLE estimate is a 12-month risk difference of -0.0304 (95% CI
-0.0461 to -0.0147). The crude risk difference is +0.0076, illustrating the
intended sign reversal from confounding by indication. The independent
intervention simulation has a risk-difference truth of approximately -0.037.

## Provenance and continuity

The fixed dataset and data-generating process come from
`ops/materials/sessions/Session 1a/R example/pneumonia_vaccine_example.Rmd`.
Module F standardizes on this Session 1 example so the story, DAG, counts, and
results remain consistent with Module D and the Module G TMLE handoff.

[Return to the seminar overview](../../README.md)