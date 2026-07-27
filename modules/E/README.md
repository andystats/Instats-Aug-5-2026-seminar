# Module E — Audit-First AI

## Purpose

Audit an AI-proposed adjustment set, decide whether to accept, correct, or
reject each claim, and document the evidence behind every decision.

## Materials

- [Compiled Beamer slides](Segment_E_Audit.pdf)
- [Editable LaTeX source](Segment_E_Audit.tex)
- [Slide artwork](art/)

The 14-slide deck contains the worked audit, participant transfer task, answer
key, and handoff into the Module F Navigator activity.

## Rebuild

From this folder, run:

```sh
latexmk -pdf Segment_E_Audit.tex
```

`latexmk` handles the multiple LaTeX passes required by the TikZ diagrams. To
remove auxiliary build files afterward, run `latexmk -c Segment_E_Audit.tex`.

[Return to the seminar overview](../../README.md)
