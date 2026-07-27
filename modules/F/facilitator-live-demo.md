# Module F facilitator guide: co-authored Navigator workshop

## Workshop purpose

Module F is a 55-minute guided workshop, not a software tour. The facilitator
operates the Causal Navigator while participants co-author a decision log. By
the end, each participant should be able to accept, correct, or reject one
Navigator entry, cite the evidence for that decision, and name the downstream
consequence of revising it.

Use the manual, no-login route at
<https://navigator.tao-rwd.com/navigator/1>. AI support is not used in this
workshop.

## Evidence and language contract

Keep these constraints visible throughout the session:

- The supplied data are fixed, synthetic teaching data. They contain no patient
  data and are not evidence about clinical vaccine effectiveness.
- The fixed CSV, DAG, analysis, and outputs are archived here; Module G
  archives the generator and a -4.04-point model-implied benchmark for the
  frozen cohort. Do not call that benchmark an exact superpopulation truth or
  claim that an estimator recovered it.
- Exchangeability, consistency, and no interference are stipulated for the
  exercise; the fixed observed data cannot prove them.
- The fitted parametric propensity-score range, approximately 0.0765 to 0.9091,
  is an overlap diagnostic for this fitted model and observed covariate
  distribution. It is not proof of structural positivity.
- No repeated estimator simulation, bias analysis, or RMSE comparison was
  performed.
- This module does not compute an E-value. Do not add one to the live
  interpretation.
- Report the course-facing TMLE result as a risk difference of **-3.0 percentage
  points** with a 95% confidence interval of **-4.6 to -1.5 percentage points**.
  The comparison estimates are g-computation **-3.28 percentage points** and
  Hajek IPW **-2.94 percentage points**.

## Before the session

1. Open a clean browser profile at
   <https://navigator.tao-rwd.com/navigator/1>.
2. Confirm that the eight-step sidebar and **Export study summary** menu are
   visible.
3. Keep these facilitator-only files open:

   - `causal-roadmap-pneumonia-worked-example.md`
   - `pneumonia.dagitty.txt`
   - `outputs/pneumonia_results.csv`

4. Give participants `pneumonia-navigator-student-guide.md`, which intentionally
   withholds the adjusted results and completed entries.
5. Do not distribute or display the completed worked example until after the
   Step 8 interpretation exercise.
6. Use the no-login manual route and do not open the AI panel.
7. If browser state is not clean, use **Reset** and confirm the prompt.
8. Rehearse the static fallback using the screenshots in `art/`.
9. Keep the Module G live deck ready for the direct handoff. It uses this same
   dataset, estimand, adjustment set, and reporting scale.

## 55-minute co-authored flow

| Time | Navigator work | Participant action | Facilitator move |
| --- | --- | --- | --- |
| 0-4 min | Orientation | Open the decision log and choose one field to track | Explain that Module D's nine-step teaching sequence is grouped into the Navigator's eight operational steps; Step 1 contains the question and causal contrast |
| 4-9 min | Opening paradox | Individually predict what must be specified before interpreting the crude contrast, then compare with a partner | Show 7.19% versus 6.43% and the crude risk difference of +0.76 percentage points; hold back every adjusted result |
| 9-16 min | Step 1: question | Draft population, treatment, comparator, time zero, outcome window, and contrast before the prepared entry appears | Enter the consensus specification and ask which phrase would most change the estimand |
| 16-23 min | Steps 2-3: model and data | Propose the adjustment set, reject post-baseline descendants, and map each protocol element to a variable and measurement time | Paste the complete DAG, attach it, and test whether the proposed mapping changes the scientific question |
| 23-33 min | Step 4: identification | Choose the weakest assumption, name evidence that would support it, and propose one design response if it fails | Treat this as the main workshop activity; take two defended examples in plenary |
| 33-39 min | Steps 5-6: estimand and estimator | Explain which assumptions link the causal target to the observed-data estimand; state one problem TMLE cannot repair | Lock the estimand and estimator without showing the adjusted result |
| 39-44 min | Step 7: sensitivity | Choose one causal or measurement gap and specify an analysis or new evidence that would illuminate it | Separate sampling uncertainty from causal uncertainty |
| 44-49 min | Result reveal | Record g-computation, IPW, and TMLE; compare direction and magnitude | Reveal the results together and emphasize that agreement does not validate the assumptions |
| 49-54 min | Step 8: interpretation | Accept, correct, or reject a proposed conclusion; cite one assumption and one limitation | Release the completed worked example only after participants have committed to an interpretation |
| 54-55 min | Export and close | Save the decision log and exported Markdown record | Export the study summary and hand off to the aligned Module G live example |

## Tactical Navigator sequence

1. Complete Step 1 through **Summary Measure** only after participants draft
   their own specification.
2. In Step 2, select **Bring your own**, paste `pneumonia.dagitty.txt`, and attach
   it.
3. Complete the causal-model fields and Step 3 data mapping.
4. Pause at Step 4. Ask participants to record:

   - their weakest assumption;
   - evidence they would seek;
   - what would make them revise the entry; and
   - one design change if the assumption is not credible.

5. Complete Step 5 using the 12-month average risk difference and its
   observed-data mapping.
6. Before Step 6, ask: “What can an estimator reduce, and what can it never
   repair?”
7. Complete Steps 6-7 before displaying any adjusted estimate.
8. At Step 8, enter the rounded course-facing results:

   | Analysis | Risk difference |
   | --- | ---: |
   | Crude association | +0.76 percentage points |
   | Parametric g-computation | -3.28 percentage points |
   | Hajek IPW | -2.94 percentage points |
   | TMLE | -3.0 percentage points (95% CI -4.6 to -1.5) |

9. Ask participants to accept, correct, or reject the proposed interpretation.
10. Open **Export study summary** and choose Markdown.

## Core discussion prompts

- Which Step 1 phrase most changes the target estimand?
- Does the proposed adjustment set follow from the DAG we are willing to
  defend?
- Can every protocol element be operationalized without changing the question?
- Which identification assumption is weakest in a real EHR study, and what
  evidence would change that judgment?
- What can the fitted propensity range tell us, and what can it not establish?
- Why does an influence-function confidence interval not measure unmeasured
  confounding, outcome error, selection, treatment versions, or interference?
- What is the strongest defensible conclusion from this fixed synthetic
  dataset?

## Result language

Recommended:

> In this fixed synthetic teaching dataset, the crude association is positive,
> while g-computation, IPW, and TMLE estimates are negative under the stipulated
> adjustment plan. This illustrates how an explicit causal roadmap can change
> the analysis and interpretation.

Avoid:

> The vaccine prevents pneumonia in real patients.

Also avoid saying that the analysis recovered an exact truth, proved
exchangeability, proved positivity, or demonstrated estimator bias or RMSE.

## Recovery plan

- If the production site is unavailable, use the ordered screenshots in `art/`
  and continue the decision-log discussion. The pedagogical objective is the
  audit, not completion of the interface.
- If a manual entry disappears, paste it again from the facilitator-only
  completed example. Manual entries persist only in that browser.
- If cross-validation or package versions move the third decimal, report the
  rounded TMLE value of -3.0 percentage points with the rounded 95% confidence
  interval of -4.6 to -1.5 and continue.
- If time is lost, shorten the interface orientation and Step 3 typing. Preserve
  the Step 4 audit, Step 8 interpretation, and final decision defense.
- If time is short, close with “estimation is downstream of the science” and
  point participants to the aligned Module G live deck for the full walkthrough.
