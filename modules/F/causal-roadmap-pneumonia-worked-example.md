# Module F completed Navigator record

Facilitator answer key: release after the participant interpretation exercise.

Worked example: pneumococcal vaccination and 12-month pneumonia
hospitalization.

> **Evidence status.** This module uses a fixed synthetic teaching dataset. It
> is not clinical evidence. The module archives the CSV, DAG, analysis script,
> and analysis outputs, but it does not archive the data generator or an
> intervention-level causal truth. The causal model and identifying assumptions
> below are stipulated for the exercise; they are not proven by the fixed
> observed data.

## Step 1: Define Causal Question

### Question Type

Effect of a point intervention; average treatment effect on the 12-month risk
difference scale.

### Motivation and Background

The teaching scenario is designed around confounding by indication: people at
higher baseline risk may be more likely to receive vaccination. The exercise
asks whether explicitly connecting the question, model, assumptions, estimand,
and estimator changes the analysis and the strength of the interpretation.

### Population and Eligibility Criteria

Fixed synthetic health-system cohort of 5,000 adults eligible for pneumococcal
vaccination at a baseline encounter. The age distribution is centered at 65
years; this is **not** an age-65-and-older cohort. Age and prior
pneumonia/vaccination history are recorded before treatment.

### Treatment Strategy

\(A=1\): receive the current pneumococcal vaccine at baseline.

### Comparator Strategy

\(A=0\): do not receive the current pneumococcal vaccine at baseline.

### Outcome

\(Y=1\): hospitalization with pneumonia within 12 months.

### Follow-up Period and Time Zero

Time zero is the baseline eligibility and vaccination decision. Follow-up begins
at that same point and continues for 12 months. The fixed teaching data contain
complete outcomes and no recorded censoring.

### Summary Measure

Primary causal contrast: 12-month average risk difference,
\(E[Y^1]-E[Y^0]\).

## Step 2: Specify Causal Model

### Study Type

Fixed synthetic point-treatment cohort framed as a target-trial emulation.

### Stipulated Baseline Common Causes \(W\)

Age, prior pneumonia, and prior pneumococcal vaccination are treated as baseline
common causes of current vaccination and pneumonia hospitalization for this
exercise. This role is a teaching-model stipulation; the missing generator
prevents independent verification that the fixed data were produced by exactly
this causal structure.

### Potential Unmeasured Common Causes in Real Data

Frailty, smoking or COPD severity, healthcare-seeking, access, provider
recommendation, functional status, and socioeconomic factors.

### Mediators and Colliders

No mediator or collider is included in the baseline teaching model. Do not
adjust automatically for post-vaccination immune response, subsequent
infections, or post-baseline healthcare use when targeting the total effect.

### Censoring Mechanism

No censoring is recorded in the fixed dataset. A real study would need to
address death, disenrollment, and loss of observable follow-up.

### DAG

The complete teaching DAG is stored in `pneumonia.dagitty.txt`:

- \(A \rightarrow Y\);
- age points to prior pneumonia, prior vaccination, \(A\), and \(Y\);
- prior pneumonia points to \(A\) and \(Y\); and
- prior vaccination points to \(A\) and \(Y\).

Under this stipulated DAG, the proposed baseline adjustment set is age, prior
pneumonia, and prior vaccination.

## Step 3: Consider Observed Data

### Data Source and Reproducibility Status

`data/pneumonia_data.csv` is a fixed synthetic teaching dataset with one row per
person. The module does not include the generator code, so the generation
mechanism, generation seed, and intervention-level causal truth cannot be
reproduced from this module alone.

### Data Structure

Point-treatment cohort with baseline \(W\), binary treatment \(A\), and a fixed
12-month binary outcome \(Y\).

### Sample

- \(N=5{,}000\);
- 1,627 vaccinated;
- 3,373 unvaccinated; and
- 334 pneumonia hospitalizations.

The sample is fixed for teaching and was not selected through a formal power
calculation.

### Exposure, Outcome, and Covariates

- \(A\): binary current vaccination at baseline.
- \(Y\): binary pneumonia hospitalization within 12 months.
- \(W\): age in years, prior pneumonia, and prior vaccination, all recorded
  before time zero.
- No missing values are recorded in these variables.

### Time-zero Mapping

Eligibility assessment, treatment assignment, and outcome follow-up begin at
the baseline encounter.

## Step 4: Assess Identifiability

### Exchangeability

Conditional exchangeability given age, prior pneumonia, and prior vaccination
is stipulated for the workshop. It is not testable from the fixed observed data,
and the absent generator means it cannot be verified from the archived module.
In real EHR data it would require substantive evidence and would remain
uncertain.

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

### Design Responses

Align eligibility, treatment assignment, and follow-up at time zero; enrich
baseline common-cause measurement; validate treatment and outcome capture;
restrict to defensible common support; consider active comparators; and
prespecify negative controls and quantitative bias analyses.

## Step 5: Define Statistical Estimand

### Causal Estimand

\[
\psi = E[Y^1]-E[Y^0],
\]

the average 12-month risk difference under baseline vaccination versus no
baseline vaccination.

### Observed-data Statistical Estimand

\[
\psi(P)
=E_W\left\{E(Y\mid A=1,W)-E(Y\mid A=0,W)\right\}.
\]

### Link to the Causal Estimand

The statistical estimand can be interpreted as the causal estimand under the
stipulated consistency, conditional exchangeability, positivity, and no
interference assumptions.

### Censoring Adjustment

None is used because the fixed dataset contains complete 12-month outcomes. A
real analysis could require inverse-probability-of-censoring adjustment or a
longitudinal estimand and estimator.

## Step 6: Choose Estimator

### Primary Estimator

TMLE for the 12-month average risk difference.

### Nuisance-model Specification

Estimate \(\bar Q(A,W)=E(Y\mid A,W)\) and \(g(W)=P(A=1\mid W)\) with Super
Learner using `SL.glm`, `SL.glmnet`, and `SL.ranger`.

### Variable-selection Strategy

Select \(W\) from the stipulated causal model, not from treatment-outcome
p-values. Do not include post-baseline variables when targeting the total
effect.

### Work Completed Before the Adjusted-result Reveal

The question, stipulated model, adjustment set, estimand, estimator, and
sensitivity topics are fixed before revealing the adjusted estimate. The crude
association is intentionally shown at the start as the teaching paradox.

No repeated estimator simulation, bias comparison, or RMSE study was performed.

### Confidence-interval Method

Efficient-influence-function standard error and Wald 95% confidence interval.

### Prespecification Status

Teaching analysis plan fixed before the adjusted-result reveal; not externally
registered.

## Step 7: Sensitivity Analysis

### Priority Areas

- quantitative bias analysis for unmeasured confounding;
- outcome-misclassification analyses that vary sensitivity and specificity;
- selection analyses for death, disenrollment, or incomplete EHR capture in a
  real study;
- alternative nuisance learners and propensity-score handling; and
- assessment of treatment versions and interference.

### Descriptive Shift-to-null Check

An upward shift of approximately 3.0 percentage points would move the rounded
TMLE point estimate to the null. This is only a descriptive scale check, not a
completed sensitivity analysis.

### Negative Controls

No negative control is available in the fixed synthetic dataset. A real study
could prespecify an unrelated outcome or exposure with a similar confounding
structure.

## Step 8: Results and Interpretation

### Course-facing Results

| Analysis | 12-month risk difference |
| --- | ---: |
| Crude association | +0.76 percentage points |
| Parametric g-computation | -3.28 percentage points |
| Hajek IPW | -2.94 percentage points |
| TMLE | -3.0 percentage points (95% CI -4.6 to -1.5) |

The archived CSV output contains additional digits. The rounded values above are
the publication and live-presentation convention.

### Interpretation

In this fixed synthetic dataset, the crude association is positive while all
three adjusted estimators are negative under the stipulated adjustment plan.
The agreement in direction illustrates the effect of connecting the causal
question, model, assumptions, estimand, and estimator.

Estimator agreement does not prove exchangeability, positivity, consistency, or
no interference. It also does not establish that the stipulated DAG matches the
unarchived generator.

### Limitations

- fixed synthetic data;
- generator and intervention-level causal truth not archived;
- causal model and identifying assumptions stipulated rather than demonstrated;
- only three baseline adjustment variables;
- no recorded missingness or censoring;
- simplified treatment versions;
- no population transmission effects represented in the analysis; and
- no repeated estimator simulation, bias comparison, or RMSE assessment.

### Defensible Conclusion

> In this fixed synthetic teaching dataset, roadmap-guided adjustment changes
> the estimated risk difference from positive to negative under the stipulated
> causal model. The exercise supports a conclusion about the workflow, not a
> clinical conclusion about vaccination.

## Archived Reproducibility Components

| Component | Status |
| --- | --- |
| Fixed dataset | Archived at `data/pneumonia_data.csv` |
| Complete teaching DAG | Archived at `pneumonia.dagitty.txt` |
| Analysis script | Archived at `code/pneumonia_navigator_tmle.R` |
| Numerical outputs | Archived in `outputs/` |
| Data-generator code | Not archived in Module F |
| Intervention-level causal truth | Not archived or independently verifiable in Module F |

## Cross-module Handoff

Do not state that Module G implements this exact worked example until Module G
uses the same fixed dataset, variables, estimand, and numerical results. Until
then, the safe handoff is:

> Estimation is downstream of the scientific question, causal model,
> identification argument, and estimand developed here.
