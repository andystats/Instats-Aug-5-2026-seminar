# Module F facilitator live-demo guide

## Before the session

1. Open a clean browser profile at https://navigator.tao-rwd.com/navigator/1.
2. Confirm the eight-step sidebar and the **Export study summary** menu are visible.
3. Keep these files open:
   - `causal-roadmap-pneumonia-worked-example.md`
   - `pneumonia.dagitty.txt`
   - `outputs/pneumonia_results.csv`
4. Use the no-login manual route. Do not open the AI panel.
5. If browser state is not clean, use **Reset** and confirm the destructive prompt.

## Suggested 55-minute workshop flow

| Time | Activity | Teaching move |
| --- | --- | --- |
| 0-5 min | Very light Navigator orientation | The eight steps are the Module D roadmap grouped for use, not a new method |
| 5-12 min | Reveal the crude pneumonia paradox | Ask what story the crude risks appear to tell |
| 12-22 min | Steps 1-3 | Align the target trial, attach the DAG, and map the observed data |
| 22-32 min | Step 4 audit pause | Ask which assumption would fail first in real EHR data |
| 32-40 min | Steps 5-7 | Lock the estimand, estimator, and sensitivity plan before the result |
| 40-48 min | Step 8 result reveal | Compare crude, g-computation, IPW, TMLE, and simulation truth |
| 48-53 min | Participant challenge | Students defend or revise one Navigator entry |
| 53-55 min | Export and handoff | Export the roadmap; Module G implements the estimator chosen here |

## Tactical paste order

1. Complete Step 1 through **Summary Measure**.
2. In Step 2, select **Bring your own**, paste `pneumonia.dagitty.txt`, and attach it.
3. Complete Steps 2-5.
4. Pause before Step 6 and ask: "What can an estimator repair, and what can it never repair?"
5. Complete Steps 6-7 before showing the adjusted result.
6. Enter Step 8 from `outputs/pneumonia_results.csv`.
7. Open **Export study summary** and choose Markdown.

## Discussion prompts

- Which Step 1 phrase most changes the target estimand?
- Why is prior vaccination a confounder here rather than a treatment history to ignore?
- What evidence supports exchangeability in a simulation, and why is that evidence unavailable in real data?
- Why does an influence-function confidence interval say nothing about unmeasured confounding?
- What is the strongest defensible conclusion from a synthetic study?

## Recovery plan

- If the production site is unavailable, use the screenshots in `art/` and the completed Markdown export.
- If an entry disappears, paste it again from the completed example; manual entries persist only in that browser.
- If a live result differs in the third decimal, report the rounded value (-3.0 percentage points) and continue. Cross-validation and learner implementation can cause tiny numerical differences.
