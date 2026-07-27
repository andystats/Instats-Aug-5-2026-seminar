# Segment H wrap-up review

## Publication assessment

Segment H is ready to serve as a five-minute workshop close once the canonical
Beamer PDF, participant landing page, and templates in this directory are
published together.

The final close is intentionally independent of Module G. It does not name an
estimator, dataset, numerical result, or notebook from the estimation segment.

## Changes from the seed

- Replaced the standalone title with five low-density content slides so the
  five-minute segment has time for participant action.
- Returned to Module A's exact opening prompt.
- Reframed the take-home kit as a repeatable workflow rather than a list of
  promised files.
- Added a study-specific commitment and evidence/revision trigger.
- Added a chat-based exit ticket because no verified feedback form is archived.
- Replaced the long, wrapping footer with a separate acknowledgement and a
  ten-second closing line.
- Removed unfinished or unavailable optional resources from the projected
  close.
- Corrected the acknowledgement: Auriane Journet is credited for live-delivery
  support, not as the creator of the Navigator.

## Resource and claim audit

The Module H page links to canonical Module F and G files rather than duplicating them:
participant workbook, completed roadmap, fixed synthetic CSV, DAG, live and
technical R scripts, results, diagnostics, generator, and benchmark.

The page also links to the current Causal Navigator and its verified
right-heart-catheterization example. Legacy or unavailable apps are not part of
the core kit.

The pneumonia example remains labeled as synthetic teaching material. The kit labels the frozen-cohort benchmark as
model-implied; neither the close nor the kit claims an exact causal truth, bias,
RMSE, or proof of real-world identification assumptions.

## Timing

| Slide | Planned time |
| --- | ---: |
| The roadmap is the work | 45 seconds |
| Before your next model | 75 seconds |
| Keep the workflow | 60 seconds |
| Before you go | 70 seconds |
| Final line | 10 seconds |
| Buffer | 40 seconds |

## QA completed

- [x] Beamer source compiles with `latexmk`.
- [x] PDF contains five 16:9 pages.
- [x] Every page rendered to PNG and received individual visual inspection.
- [x] No audience-facing content is clipped or overlapped.
- [x] PDF text is searchable.
- [x] The Module H URL is an explicit clickable hyperlink.
- [x] The closing content remains valid if Module G changes.
- [x] Participant-kit links use canonical Module D/F/G files.
- [x] Box and GitHub packages contain the same canonical files.
