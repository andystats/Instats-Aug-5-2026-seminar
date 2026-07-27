# Module G live run of show

This guide delivers the 15-slide live deck in **35 minutes**. The 32-slide
technical supplement is an after-session resource, not part of the live run.

## Before the segment

- Run `Rscript modules/G/pneumonia_tmle_example.R` once in the delivery
  environment. Do not install packages during the session.
- Keep `outputs/pneumonia_tmle_technical_results.csv`,
  `outputs/pneumonia_tmle_technical_diagnostics.csv`, and both figures in
  `art/` open as fallbacks.
- Use the stable live convention for the primary result: about **-3.0
  percentage points**, 95% CI about **-4.6 to -1.5**.
- Remember that the displayed overlap plot is the parametric-GLM comparator
  diagnostic. The archived TMLE Super Learner \(g\) range is 0.092 to 0.894.

## Run of show

| Time | Slides | Facilitator action |
| ---: | --- | --- |
| 0-3 min | 1-2 | Reconnect to Module F: the question, population, outcome, adjustment set, time horizon, and estimand remain fixed. |
| 3-7 min | 3-4 | Re-establish the cohort and crude paradox. Ask why a positive crude association need not be a treatment effect. |
| 7-12 min | 5 | Compare crude, g-computation, IPTW, and TMLE while keeping the risk-difference target fixed. |
| 12-18 min | 6-8 | Explain standardization, weighting, and fitted support. Name the parametric comparator and TMLE Super Learner propensity ranges separately. |
| 18-24 min | 9-10 | Introduce the targeting update, then run or reveal the compact R example. |
| 24-29 min | 11-13 | Show the audit trail, estimator comparison, and stable rounded TMLE result. Emphasize that estimator agreement is an implementation check. |
| 29-34 min | 14-15 | Return causal interpretation to the study assumptions and complete the roadmap. |
| 34-35 min | Handoff | Point to the optional technical supplement, then move directly to Module H. |

## Recovery options

- **The R run fails:** use the committed results table and figures. Do not debug
  packages in front of participants.
- **The last decimal differs:** report the stable one-decimal convention and
  note that full-precision Super Learner output is software-version dependent.
- **Five minutes are lost:** skip the live code walk-through and show its output;
  retain the assumptions and roadmap close.
- **The overlap plot is challenged:** state that it is a fitted
  parametric-GLM comparator diagnostic, not proof of structural positivity and
  not the Super Learner \(g\) fit used inside TMLE.
- **A technical question expands:** park it for
  `SegmentG_TMLE_Technical_Supplement.pdf`.

## Delivery boundary

The data are synthetic teaching material, not clinical evidence. The
model-implied benchmark is available because the generator is archived; it is
not an observed result or an exact superpopulation truth.
