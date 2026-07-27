# Pneumonia Navigator participant decision log

## Workshop contract

The facilitator will operate the Causal Navigator. Your job is to co-author and
audit the decisions.

For each checkpoint:

1. make a decision before the prepared entry appears;
2. record the evidence that supports it;
3. state what would make you revise it; and
4. name the downstream consequence of that revision.

Open the manual, no-login route at
<https://navigator.tao-rwd.com/navigator/1>.

> **Synthetic teaching data only.** The fixed dataset contains no patient data
> and provides no evidence about real vaccine effectiveness, safety, or policy.
> The generator and model-implied benchmark are available in Module G after
> the activity; they are not used to answer the pre-result checkpoints.

## Opening case

Scientific question:

> Among adults in a synthetic health-system cohort, what is the effect of
> receiving a pneumococcal vaccine at baseline, compared with not receiving it,
> on the 12-month risk of hospitalization with pneumonia?

Facts supplied at the start:

| Item | Observed value |
| --- | ---: |
| People | 5,000 |
| Vaccinated | 1,627 |
| Pneumonia hospitalizations | 334 |
| Vaccinated 12-month risk | 7.19% |
| Unvaccinated 12-month risk | 6.43% |
| Crude risk difference | +0.76 percentage points |

Before interpreting that crude contrast, complete the checkpoints below.
Adjusted results are intentionally withheld until Steps 1-7 are locked.

## Eight-step spine

The Navigator groups the roadmap into eight operational steps:

1. define the causal question;
2. specify the causal model;
3. consider the observed data;
4. assess identifiability;
5. define the statistical estimand;
6. choose the estimator;
7. plan sensitivity analyses; and
8. interpret the results.

Module D used a nine-step teaching sequence. In the Navigator, the scientific
question and causal contrast are recorded together in Step 1; the later labels
shift accordingly.

## Checkpoint 1: define the question

Draft the target trial before the prepared entry appears.

| Field | Your entry |
| --- | --- |
| Population and eligibility |  |
| Treatment strategy |  |
| Comparator strategy |  |
| Time zero |  |
| Outcome |  |
| Follow-up window |  |
| Causal contrast |  |

Which single phrase in your specification would most change the target
estimand?

_Your response:_

## Checkpoint 2: specify the model

Candidate nodes for the workshop model are:

- age;
- prior pneumonia;
- prior pneumococcal vaccination;
- current baseline vaccination \(A\); and
- 12-month pneumonia hospitalization \(Y\).

Draw or describe the arrows you are willing to defend.

| Decision | Your response |
| --- | --- |
| Proposed sufficient adjustment set |  |
| Why each selected variable belongs |  |
| Variables that must not be adjusted for |  |
| Evidence that would make you revise the DAG |  |

Accept, correct, or reject this statement:

> Post-baseline healthcare use should be added automatically because it predicts
> the outcome.

_Disposition and reason:_

## Checkpoint 3: map the observed data

The fixed CSV has one row per person, baseline covariates, a binary baseline
treatment, and a binary 12-month outcome. It has no recorded missingness or
censoring.

| Protocol element | Variable or operational definition | Measurement time | Main concern |
| --- | --- | --- | --- |
| Eligibility |  |  |  |
| Treatment |  |  |  |
| Comparator |  |  |  |
| Outcome |  |  |  |
| Baseline common causes |  |  |  |
| Follow-up |  |  |  |

Can every Step 1 element be represented without changing the scientific
question?

_Your response:_

## Checkpoint 4: audit identification

For this exercise, the causal model and identifying assumptions are
**stipulated**, not proven by the fixed data.

| Assumption | Provisional disposition | Evidence you would seek | What would make you revise it or redesign the study |
| --- | --- | --- | --- |
| Exchangeability given baseline \(W\) |  |  |  |
| Positivity |  |  |  |
| Consistency |  |  |  |
| No interference |  |  |  |

The fitted parametric propensity-score range is approximately 0.0765 to 0.9091.
What does that diagnostic tell you, and what does it leave unresolved?

_Your response:_

## Checkpoint 5: connect causal target and statistical estimand

Write the causal target:

_Your response:_

Write the observed-data statistical estimand:

_Your response:_

Which Step 4 assumptions are required to interpret the statistical estimand as
the causal target?

_Your response:_

## Checkpoint 6: choose the estimator

| Decision | Your response |
| --- | --- |
| Proposed primary estimator |  |
| Outcome-regression plan |  |
| Treatment-mechanism plan |  |
| Uncertainty interval |  |
| One statistical problem this estimator may reduce |  |
| One scientific or design problem it cannot repair |  |

No repeated estimator simulation, bias comparison, or RMSE study is part of
this exercise.

## Checkpoint 7: plan sensitivity work

Choose one gap and specify an analysis or new source of evidence that would make
it more transparent.

| Gap | Proposed analysis or evidence | Result that would change your interpretation |
| --- | --- | --- |
| Unmeasured confounding |  |  |
| Outcome misclassification |  |  |
| Selection or incomplete capture |  |  |
| Alternative learners or propensity handling |  |  |
| Treatment versions or interference |  |  |

A confidence interval for the statistical estimand does not quantify these
causal and measurement gaps.

## Checkpoint 8: record the result after the reveal

Do not complete this table until the facilitator reveals the adjusted results.

| Analysis | Risk difference | What it adds to the interpretation |
| --- | ---: | --- |
| Crude association | +0.76 percentage points |  |
| Parametric g-computation |  |  |
| Hajek IPW |  |  |
| TMLE with 95% confidence interval |  |  |

First compare the estimators with one another. The optional Module G supplement
then provides a -4.04-point model-implied benchmark for the frozen cohort; it
is not an observed result or evidence about a real study.

## Workshop deliverable

Choose one Navigator entry and complete the decision:

| Prompt | Your response |
| --- | --- |
| Field and step |  |
| Accept, correct, or reject |  |
| Evidence that makes the entry defensible |  |
| What would make you revise it |  |
| Downstream decision that changes if you revise it |  |

After you have defended the entry, compare your reasoning with
`causal-roadmap-pneumonia-worked-example.md`. The completed record is an answer
key, not a substitute for your argument.
