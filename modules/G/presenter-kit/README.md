# Segment G presenter kit

Everything a facilitator or assistant needs to run the optional analytics
handoff demonstration, and to recover if it will not run. Written to be usable
offline and shareable on its own.

> **Evidence status.** Fixed synthetic teaching dataset. Not clinical evidence.
> The demonstration shows that a specification, and then a summary result, can
> travel without the row-level data. It does not audit the estimate it carries.

## What the demonstration claims, in one sentence

The study plan built in Module F travels to the analysis and back again without
the dataset ever leaving the analyst's machine.

## The five moves, with timings

| # | Move | Time | What the room should notice |
| --- | --- | --- | ---: |
| 1 | Open the study in the Navigator, go to Analytics | 2 min | The plan from Module F is already there |
| 2 | Drop **only** the data dictionary | 2 min | The column mapping fills itself; no dataset was opened |
| 3 | Export the analysis code | 2 min | The code names their columns, not ours |
| 4 | Run it at home, paste `pneumonia-results.json` | 3 min | Summary numbers return; the cohort does not |
| 5 | Attach, then open Step 8 | 2 min | The write-up drafts itself and refuses to conclude |

Full narration: [`../facilitator-analytics-handoff.md`](../facilitator-analytics-handoff.md).

## Before you present

1. Download the kit from the app:
   <https://navigator.tao-rwd.com/kits/pneumonia-tmle/pneumonia-tmle.zip>
   (cohort CSV, dictionary, R script, example results, README).
2. Run `Rscript run_pneumonia_tmle.R` once on the machine you will present
   from. It takes a couple of minutes and needs `tmle`, `SuperLearner`,
   `glmnet`, `ranger`, and `jsonlite`.
3. Confirm the console prints the four numbers in the table below.
4. Keep `pneumonia-results.json` open in a text editor. If the live run fails,
   paste it and continue.

Optional: export `KIT_STUDY_ID=<your study id>` before running and the Navigator
confirms the results belong to that study instead of warning about a mismatch.
The study id is in the Navigator URL, `/study/<id>/navigator`.

## The numbers, and the one that matters

| Analysis | 12-month risk difference |
| --- | ---: |
| Crude association | **+0.76 pp** |
| Parametric g-computation | -3.28 pp |
| Hajek IPW | -2.94 pp |
| TMLE | -3.05 pp (95% CI -4.60 to -1.50) |
| Model-implied benchmark, frozen cohort | -4.04 pp |

The crude comparison says vaccination is harmful. Everything that respects the
stipulated causal model says it is protective. That sign flip is the segment.

Say: the benchmark is the value the generating model implies for this fixed
cohort. Do not say: the estimator recovered the truth, the fitted propensity
range proves positivity, or estimator agreement proves the assumptions.

## What is in this folder

| File | Use |
| --- | --- |
| `README.md` | This orientation |
| `completed-navigator-record.md` | The finished study, Steps 1 to 8, with Step 8 exactly as the tool drafted it |
| `pneumonia-results.json` | The safe output to paste if the live run fails |

Supporting material already in the repository:

| Path | Use |
| --- | --- |
| [`../facilitator-analytics-handoff.md`](../facilitator-analytics-handoff.md) | Full run sheet and troubleshooting table |
| [`../data/pneumonia_dictionary.csv`](../data/pneumonia_dictionary.csv) | The dictionary to drop in step 2 |
| [`../data/pneumonia_data.csv`](../data/pneumonia_data.csv) | The cohort |
| [`../pneumonia_tmle_example.R`](../pneumonia_tmle_example.R) | The Module G live analysis |
| [`../../F/causal-roadmap-pneumonia-worked-example.md`](../../F/causal-roadmap-pneumonia-worked-example.md) | Module F answer key |

## If it will not run

| Symptom | What to do |
| --- | --- |
| No network | Show `completed-navigator-record.md` and talk through the five moves |
| Mapping stays empty | Confirm you dropped the dictionary, and that it has a `role` column |
| Export button greyed out | Set both contrast values; they must differ |
| "Could not parse as kit results" | Paste the whole `pneumonia-results.json`, not the console table |
| Amber "different study's id" | Expected if the results were bound to another study. Load that study, or attach deliberately |

The segment survives every one of these. The point is the workflow, and the
completed record in this folder carries it on its own.

## Rehearsed

Carried end to end in the production Navigator on 2026-08-02 in a study named
"Segment G rehearsal": dictionary-only mapping, export, a real local R run,
paste, attach, and the Step 8 write-back reproduced in
`completed-navigator-record.md`.
