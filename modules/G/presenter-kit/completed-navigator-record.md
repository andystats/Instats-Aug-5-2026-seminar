# Completed Navigator record: Segment G rehearsal

Exported from a real Causal Navigator study created on 2026-08-02 as a
rehearsal for the August 5 session. Steps 1 to 7 were entered from the Module F
answer key. **Step 8 was left blank on purpose** and is exactly what the
analytics handoff wrote back after the local run was attached, so this file
shows what the tool produces rather than what a facilitator typed.

> **Evidence status.** Fixed synthetic teaching dataset. Not clinical evidence.

## Step 1: Define Causal Question

### Question Type

Effect of a point intervention; average treatment effect on the 12-month risk
difference scale.

### Motivation

Teaching scenario built around confounding by indication: people at higher
baseline risk may be more likely to be vaccinated. The exercise asks whether
explicitly connecting question, model, assumptions, estimand, and estimator
changes the analysis and the strength of the interpretation.

### Population

Fixed synthetic health-system cohort of 5,000 adults eligible for pneumococcal
vaccination at a baseline encounter. Age is centred near 65; this is NOT an
age-65-and-older restriction. Age and prior pneumonia/vaccination history are
recorded before treatment.

### Treatment

A=1: receive the current pneumococcal vaccine at baseline.

### Comparator

A=0: do not receive the current pneumococcal vaccine at baseline.

### Outcome

Y=1: hospitalization with pneumonia within 12 months.

### Follow-up

Time zero is the baseline eligibility and vaccination decision. Follow-up begins
at that same point and continues for 12 months. The fixed teaching data contain
complete outcomes and no recorded censoring.

### Summary Measure

Primary causal contrast: 12-month average risk difference, E[Y^1] - E[Y^0].

## Step 2: Specify Causal Model

### Study Type

Fixed synthetic point-treatment cohort framed as a target-trial emulation.

### Confounders

Age, prior pneumonia, and prior pneumococcal vaccination are baseline common
causes of current vaccination and pneumonia hospitalization in the archived
teaching generator. That verifies the synthetic construction, not the causal
structure of a real health-system study.

### Unmeasured

In real data: frailty, smoking or COPD severity, healthcare-seeking, access,
provider recommendation, functional status, and socioeconomic factors.

### Mediators

No mediator or collider is included in the baseline teaching model. Do not
adjust automatically for post-vaccination immune response, subsequent
infections, or post-baseline healthcare use when targeting the total effect.

### Censoring

No censoring is recorded in the fixed dataset. A real study would need to
address death, disenrollment, and loss of observable follow-up.

### DAG Status

Complete teaching DAG archived at `modules/F/pneumonia.dagitty.txt` (five nodes,
nine edges).

### DAG Description

A -> Y; age -> prior pneumonia, prior vaccination, A, Y; prior pneumonia -> A,
Y; prior vaccination -> A, Y. Under this stipulated DAG the proposed baseline
adjustment set is age, prior pneumonia, and prior vaccination.

## Step 3: Consider Observed Data

### Data Source

`data/pneumonia_data.csv`, the fixed synthetic teaching dataset with one row per
person. Module G archives the generator, seed reconstruction, and a
deterministic model-implied benchmark for this frozen covariate distribution.

### Data Structure

Point-treatment cohort with baseline W, binary treatment A, and a fixed
12-month binary outcome Y.

### Sample Size

N = 5,000; 1,627 vaccinated; 3,373 unvaccinated; 334 pneumonia
hospitalizations.

### Sample Size Method

The sample is fixed for teaching and was not selected through a formal power
calculation.

### Exposure Definition

A: binary current vaccination at baseline.

### Outcome Definition

Y: binary pneumonia hospitalization within 12 months.

### Covariate Measurement

W: age in years, prior pneumonia, and prior vaccination, all recorded before
time zero. No missing values are recorded in these variables.

### Time Zero

Eligibility assessment, treatment assignment, and outcome follow-up all begin at
the baseline encounter.

## Step 4: Assess Identifiability

### Exchangeability

The teaching generator contains no common causes of vaccination and outcome
outside age, prior pneumonia, and prior vaccination, so conditional
exchangeability is part of the synthetic construction. It is not testable from
the fixed observed data. In real EHR data it would require substantive evidence
and would remain uncertain.

### Positivity

A fitted parametric treatment model gives propensity scores from approximately
0.0765 to 0.9091 in the observed covariate distribution. This is a useful
diagnostic for obvious fitted-model overlap problems. It does not prove
structural positivity, establish that both strategies are possible in every
target stratum, or validate the treatment model.

### Consistency

The exercise stipulates a single baseline vaccination decision. Real studies
must distinguish product, dose, timing, prior immunization history, adherence,
and other treatment versions.

### No Interference

No interference is stipulated for the exercise. Vaccination can have
transmission-mediated population effects, so the assumption would require
careful justification in a real study.

### Causal Gap

The remaining causal gap is not identified or quantified by the fixed data.
Potential real-data gaps include residual confounding, measurement error,
selection, treatment versions, and interference.

### Modifications

Align eligibility, treatment assignment, and follow-up at time zero; enrich
baseline common-cause measurement; validate treatment and outcome capture;
restrict to defensible common support; consider active comparators; and
prespecify negative controls and quantitative bias analyses.

## Step 5: Define Statistical Estimand

### Causal Estimand

psi = E[Y^1] - E[Y^0], the average 12-month risk difference under baseline
vaccination versus no baseline vaccination.

### Statistical Estimand

psi(P) = E_W{ E(Y | A=1, W) - E(Y | A=0, W) }.

### Link to Causal Estimand

The statistical estimand can be interpreted as the causal estimand under the
stipulated consistency, conditional exchangeability, positivity, and
no-interference assumptions.

### Censoring Handling

None is used because the fixed dataset contains complete 12-month outcomes. A
real analysis could require inverse-probability-of-censoring adjustment or a
longitudinal estimand and estimator.

## Step 6: Choose Estimator

### Estimator

TMLE for the 12-month average risk difference.

### Nuisance Models

Estimate Qbar(A,W) = E(Y | A,W) and g(W) = P(A=1 | W) with Super Learner using
`SL.glm`, `SL.glmnet`, and `SL.ranger` (three-fold cross-validation).

### Variable Selection

Select W from the stipulated causal model, not from treatment-outcome p-values.
Do not include post-baseline variables when targeting the total effect.

### Simulation Results

No repeated estimator simulation, bias comparison, or RMSE study was performed.
The question, stipulated model, adjustment set, estimand, estimator, and
sensitivity topics are fixed before revealing the adjusted estimate; the crude
association is shown first as the teaching paradox.

### CI Method

Efficient-influence-function standard error and Wald 95% confidence interval.

### Prespecification

Teaching analysis plan fixed before the adjusted-result reveal; not externally
registered.

## Step 7: Sensitivity Analysis

### Primary Sensitivity

Priority areas: quantitative bias analysis for unmeasured confounding;
outcome-misclassification analyses varying sensitivity and specificity;
selection analyses for death, disenrollment, or incomplete EHR capture;
alternative nuisance learners and propensity-score handling; and assessment of
treatment versions and interference.

### Unmeasured Confounding

Quantitative bias analysis is the priority area. Not performed on the fixed
teaching dataset.

### Outcome Misclassification

Vary outcome sensitivity and specificity in a real study; not performed here.

### Selection Bias

A real study would analyse death, disenrollment, and incomplete EHR capture. The
fixed dataset records none.

### G Value

Descriptive shift-to-null check only: an upward shift of approximately 3.0
percentage points would move the rounded TMLE point estimate to the null. This
is a scale check, not a completed sensitivity analysis.

### Negative Controls

No negative control is available in the fixed synthetic dataset. A real study
could prespecify an unrelated outcome or exposure with a similar confounding
structure.

## Step 8: Results and Interpretation

Everything below was written by the Navigator when the local run was attached.
No facilitator typed it. It is a **draft**: the closing language is deliberately
unfinished so participants have something to argue with.

### Primary Result

Run-at-home point-treatment result for A = 1 vs 0 on Y.
G-computation: -3.28 pp (Parametric outcome model, standardized).
Hajek IPW: -2.94 pp (Stabilized inverse probability weighting).
TMLE: -3.05 pp (95% CI -4.60 pp to -1.50 pp) (tmle package with SuperLearner (glm, glmnet, ranger)).

### Unadjusted Result

Unadjusted comparison from local kit output: +0.76 pp.
Cohort counts used by the kit: total 5,000, treated 1,627, comparator 3,373, events 334.
The unadjusted and adjusted estimates point in opposite directions, which is what confounding of this contrast would look like.

### Interpretation Level

Draft from safe analytics handoff. Interpret causally only to the extent that the Navigator assumptions remain credible: target-trial alignment, exchangeability given the measured adjustment set, positivity, and consistency. Otherwise, describe as an adjusted association.

### Alternative Designs

Compare this run-at-home observational analysis against the target trial specified earlier in the Navigator and any feasible alternative designs. Note where randomization, richer measurement, or negative controls would change the strength of the evidence.

### Limitations

Estimates come from a local run returning summary output only; row-level data was not reviewed here.
Adjustment was limited to the measured set: age, priorPneumonia, priorVaccine.
Estimated propensity ranged from 0.0765 to 0.9091; check positivity at the extremes.

### Conclusions

Draft conclusion pending domain review. Use the returned estimates, diagnostics, and the earlier Navigator assumptions to decide whether the result supports a causal claim, an adjusted association, or a teaching-example conclusion.

## Where the drafted Step 8 stops, and Module F continues

The tool drafts scaffolding and refuses to conclude. The defensible conclusion
is the facilitator's, and Module F states it:

> In this fixed synthetic teaching dataset, roadmap-guided adjustment changes
> the estimated risk difference from positive to negative under the stipulated
> causal model. The exercise supports a conclusion about the workflow, not a
> clinical conclusion about vaccination.
