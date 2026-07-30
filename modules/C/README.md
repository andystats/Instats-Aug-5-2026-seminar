# Module C — Foundations

## Purpose

Introduce association versus intervention, counterfactual contrasts, causal
structures, target-trial protocols, time-zero alignment, and the
identification assumptions (exchangeability, positivity, consistency).

Runs 12:20–1:05 pm ET, led by Kathryn.

## Materials

- [Editable LaTeX source](Segment_C_Foundations.tex)
- [Compiled Beamer slides](Segment_C_Foundations.pdf)

The deck covers counterfactual and causal-structure examples, the target-trial
protocol, the pneumonia-vaccine example, and the identification assumptions —
exchangeability, positivity, and consistency — followed by an interactive poll
bank. Artwork used by the slides lives in [art/](art/).

To rebuild the Beamer slides, run `latexmk -pdf Segment_C_Foundations.tex` from
this folder. The included TikZ diagrams require multiple LaTeX passes;
`latexmk` handles them automatically.

[Return to the seminar overview](../../README.md)
