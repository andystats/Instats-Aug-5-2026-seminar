# Module H — Wrap-up + participant kit

Module H closes the seminar by reconnecting the question, design, assumptions,
estimand, estimate, and claim. Participants make one commitment for their next
study and leave with reusable roadmap and audit-log templates.

The public participant page is:

**[andystats.github.io/Instats-Aug-5-2026-seminar/modules/H](https://andystats.github.io/Instats-Aug-5-2026-seminar/modules/H/)**

## Participant start

1. Open `Next_Study_Commitment.pdf`.
2. Return to the causal claim you named at the start of the seminar.
3. Record one action you will take before fitting your next model.
4. Add the evidence or revision trigger that will make the decision reviewable.
5. Use the blank roadmap and audit log on that study.

## Canonical materials

- `SegmentH_Close.tex` — canonical five-slide 16:9 Beamer source
- `SegmentH_Close.pdf` — compiled five-minute close
- `instats-preamble.tex` — shared Beamer styling
- `Next_Study_Commitment.tex` — printable one-page action-card source
- `Next_Study_Commitment.pdf` — printable participant action card
- `next-study-commitment.md` — editable version of the action card
- `causal-roadmap-worksheet.md` — reusable nine-step worksheet with the
  eight-step Navigator mapping
- `audit-log-template.md` — accept/correct/reject evidence log
- `participant-kit.md` — concise kit manifest
- `facilitator-close.md` — 4:20 run of show with recovery options
- `WRAP_UP_REVIEW.md` — publication, claim, resource, timing, and QA record
- `index.html` — student-facing participant-kit page
- `art/InStats_RWL.png` — seminar logo used by the PDFs

The participant-kit page links to the canonical Module D, F, and G materials rather
than duplicating them. This avoids file drift and keeps the completed pneumonia
roadmap clearly separated from the reusable blank templates.

## Build the PDFs

From this directory:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error SegmentH_Close.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error Next_Study_Commitment.tex
```

The closing deck requires a standard TeX Live installation with the Metropolis
Beamer theme. The action card uses standard article, TikZ, and graphics
packages.

## Delivery boundary

The close remains intentionally estimator-agnostic, while the participant kit
links the finalized Module G live walkthrough and optional technical supplement.
The synthesis remains valid if the estimation segment changes.

The pneumonia files use fixed synthetic teaching data and are not clinical
evidence. Module G archives the generator and a model-implied frozen-cohort
benchmark. The kit does not present that benchmark as an exact truth and does
not claim estimator bias, RMSE, or real-world identification.

## Credits

Presenters: Kathryn Morrison and Andy Wilson. With thanks to Robert Platt for
the guest case and Auriane Journet for live-delivery support.

[Return to the seminar overview](../../README.md)
