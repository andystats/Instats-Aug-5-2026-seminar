# Module C — Foundations

## Purpose

Move from association to intervention, distinguish confounders, mediators, and
colliders, and show why target-trial design and time-zero alignment must precede
model fitting.

## Materials

- [Compiled Beamer slides](Segment_C_Foundations.pdf)
- [Editable LaTeX source](Segment_C_Foundations.tex)
- [Slide artwork](art/)

The 21-slide deck includes four participant poll/solution sequences and an
explicit handoff into Module D.

## Rebuild

From this folder, run:

```sh
latexmk -pdf Segment_C_Foundations.tex
```

`latexmk` handles the multiple LaTeX passes required by the TikZ diagrams. To
remove auxiliary build files afterward, run
`latexmk -c Segment_C_Foundations.tex`.

[Return to the seminar overview](../../README.md)
