# Module H — Wrap-up

Module H closes the seminar with a short, conventional four-slide sequence:
title, recap, resources/contact, and thanks. It restates the course spine without
reopening technical details or adding a new participant activity.

The public participant page remains available at:

**[andystats.github.io/Instats-Aug-5-2026-seminar/modules/H](https://andystats.github.io/Instats-Aug-5-2026-seminar/modules/H/)**

## Closing deck

- `SegmentH_Close.tex` — canonical four-slide 16:9 Beamer source
- `SegmentH_Close.pdf` — compiled five-minute close
- `instats-preamble.tex` — shared Beamer styling
- `facilitator-close.md` — concise run of show with recovery options
- `WRAP_UP_REVIEW.md` — publication, contact, timing, and QA record
- `art/InStats_RWL.png` — seminar logo used by the PDFs

The close uses the same Metropolis theme, seminar palette, title treatment, and
terminology as the other modules. It is intentionally estimator-agnostic so the
summary remains valid if the live analysis changes.

## Optional participant kit

The reusable templates remain available on the Module H participant page, but
they are no longer the organizing structure of the projected close:

- `Next_Study_Commitment.pdf` and `Next_Study_Commitment.tex`
- `next-study-commitment.md`
- `causal-roadmap-worksheet.md`
- `audit-log-template.md`
- `participant-kit.md`

The page links to the canonical Module D, F, and G materials instead of
duplicating them. The pneumonia example remains labeled as fixed synthetic
teaching data, not clinical evidence.

## Build the PDFs

From this directory:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error SegmentH_Close.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error Next_Study_Commitment.tex
```

The closing deck requires a standard TeX Live installation with the Metropolis
Beamer theme.

## Contact and credits

- Kathryn Morrison — [Precision Analytics](https://www.precision-analytics.ca/)
- Andy Wilson — [wilson.stats@gmail.com](mailto:wilson.stats@gmail.com)

With thanks to Robert Platt and Auriane Journet.

[Return to the seminar overview](../../README.md)
