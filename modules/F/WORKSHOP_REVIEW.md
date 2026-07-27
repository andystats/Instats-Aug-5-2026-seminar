# Module F workshop review and publication record

## Publication assessment

Module F is ready to serve as the workshop's central participant activity. The
facilitator operates the live Navigator while participants make and defend the
decisions. The adjusted result is held until Steps 1-7 are locked.

Module G is now a direct continuation: it uses the same fixed cohort, variables,
adjustment set, estimand, learner library, three-fold settings, and reporting
scale.

## Canonical file roles

| File | Audience | Publication role |
| --- | --- | --- |
| `facilitator-live-demo.md` | Facilitators | 55-minute run of show, evidence contract, result reveal, and recovery plan |
| `pneumonia-navigator-student-guide.md` | Participants | Pre-result workbook and decision log |
| `causal-roadmap-pneumonia-worked-example.md` | Facilitators and post-workshop participants | Completed answer key released after the activity |
| `REPRODUCIBILITY.md` | Maintainers and technical readers | Exact settings, outputs, provenance, and claim boundary |
| `WORKSHOP_REVIEW.md` | Maintainers | Final QA and publication record |

The two Beamer sources are canonical. Retained PowerPoint files are historical
source drafts and should not be edited in place.

## Pedagogical decisions retained

- The activity runs throughout the session rather than appearing only at the end.
- Participants decide before each prepared entry is shown.
- Step 4 is the main audit pause: choose the weakest assumption, name evidence,
  and propose a response if it fails.
- The final disposition uses Module E's **accept, correct, or reject** language.
- The adjusted result remains blank in the participant guide until the reveal.
- The completed worked example is labeled as a post-activity answer key.
- Static screenshots preserve the activity if the live site is unavailable.
- Module G moves directly from the locked plan to estimation and interpretation.

## Reproducibility and claim audit

Archived and reviewable materials now include:

- the fixed synthetic dataset;
- the five-node, nine-edge DAG specification;
- the standalone `simcausal` generator and seed reconstruction;
- the Module F and G R analyses;
- crude, g-computation, Hajek IPW, manual TMLE, and package TMLE outputs;
- fitted treatment-model diagnostics and package versions; and
- the -4.04-point model-implied benchmark for the frozen cohort.

Publication language must still not claim that:

- the benchmark is an exact superpopulation truth or clinical evidence;
- estimator agreement proves exchangeability, consistency, positivity, or no interference;
- the fitted propensity-score range proves structural positivity; or
- estimator bias or RMSE was evaluated.

The aligned course-facing values are:

| Analysis | Risk difference |
| --- | ---: |
| Crude association | +0.76 percentage points |
| Parametric g-computation | -3.28 percentage points |
| Hajek IPW | -2.94 percentage points |
| TMLE | -3.05 percentage points (95% CI -4.60 to -1.50) |
| Model-implied benchmark for the frozen cohort | -4.04 percentage points |

The live workshop may continue to use the rounded TMLE convention of -3.0
points with a 95% confidence interval of -4.6 to -1.5.

## Resolved cross-module checks

- **Module D:** the population is now the synthetic adult cohort with age
  centered near 65, not an age-65-plus restriction; its observed adjustment set
  matches age, prior pneumonia, and prior vaccination.
- **Module E:** the accept/correct/reject disposition language is retained.
- **Module G:** the live and technical examples implement this exact study plan.
- **Module H:** the participant kit links the Module G live deck, supplement,
  generator, and technical outputs while keeping the close estimator-agnostic.

## Format and accessibility record

- The canonical Beamer PDFs use the established 16:9 slate-and-blue system.
- Participant and facilitator PDFs contain searchable text.
- The Navigator URL remains visible in both live and participant materials.
- Screenshots are used for orientation and fallback, while critical claims and
  numerical results remain native text.
- Labels accompany color, so meaning does not depend on color alone.

## Final publication checklist

- [x] Canonical Markdown roles are synchronized.
- [x] Facilitator and participant Beamer files use the same wording and limits.
- [x] The participant materials do not reveal adjusted results before the checkpoint.
- [x] The completed answer key is gated until after the activity.
- [x] Image formats and repository links are valid.
- [x] Module D cohort wording and the Navigator mapping are aligned.
- [x] Module G directly implements the Module F example.
- [x] GitHub Pages links point to the live G landing page and participant kit.
- [x] R scripts parse and run from the repository root.
- [x] Final PDFs were rebuilt, rendered, and visually inspected.

Modules B, C, and E remain explicitly labeled as forthcoming on the public
seminar page; their absent teaching files are not represented as complete.
