# Causal Roadmap Form Export

Worked example: pneumococcal vaccination and 12-month pneumonia hospitalization

Teaching status: synthetic data only. This is not clinical evidence about vaccine effectiveness.

## Step 1: Define Causal Question

### Question Type

Effect of an intervention; point-treatment average treatment effect.

### Motivation & Background

Confounding by indication can make a protective vaccine appear harmful because higher-risk adults are preferentially vaccinated. The study asks whether current vaccination reduces 12-month pneumonia hospitalization risk.

### Population / Eligibility Criteria

Synthetic health-system cohort of 5,000 adults eligible for pneumococcal vaccination at a baseline encounter. The age distribution is centered at 65 years; this is not a literal age-65-and-older cohort. Age and prior pneumonia/vaccination history are measured before treatment.

### Treatment Strategies

A=1: receive the current pneumococcal vaccine at baseline.

### Comparator

A=0: do not receive the current pneumococcal vaccine at baseline.

### Outcome

Y=1: hospitalization with pneumonia within 12 months.

### Follow-up Period

Time zero is the baseline vaccination decision. Follow from that date through 12 months. The teaching data have complete outcomes and no censoring.

### Summary Measure (Causal Contrast)

Primary: 12-month average risk difference, E[Y^1] - E[Y^0]. Secondary: 12-month risk ratio.

## Step 2: Specify Causal Model

### Study Type

Simulated retrospective cohort framed as a point-treatment target-trial emulation.

### Measured Confounders (W)

Age, prior pneumonia, and prior pneumococcal vaccination. Each is measured before A and affects both vaccination and pneumonia risk in this simulation.

### Potential Unmeasured Confounders

In real EHR data: frailty, smoking or COPD severity, healthcare-seeking, access, provider recommendation, and socioeconomic factors. These are absent by design in the simulation.

### Mediators / Colliders

None are included in the baseline teaching model. Do not adjust for post-vaccination immune response, subsequent infections, or post-baseline healthcare use when targeting the total effect.

### Censoring Mechanism

None in the simulated data. A real study would address death, disenrollment, and loss of observable follow-up.

### DAG Status

Formal DAGitty specification prepared in `pneumonia.dagitty.txt`.

### DAG Description

A -> Y. Age, priorPneumonia, and priorVaccine each cause A and Y. Age also causes both prior-history variables. The sufficient baseline adjustment set is age, priorPneumonia, and priorVaccine.

## Step 3: Consider Observed Data

### Data Source

`data/pneumonia_data.csv`; simulated with simcausal using seed 2026; one row per person; no real patient data.

### Data Structure

Point-treatment cohort with baseline W, binary treatment A, and a fixed 12-month binary outcome Y.

### Sample Size

N=5,000; 1,627 vaccinated; 3,373 unvaccinated; 334 pneumonia hospitalizations.

### Sample Size Assessment Method

Teaching sample fixed at 5,000 for a stable demonstration; not selected by a formal power calculation.

### Exposure Definition

A is binary current vaccination at baseline, generated from age and prior-history variables.

### Outcome Definition

Y is binary pneumonia hospitalization within 12 months, simulated without measurement error.

### Covariate Measurement

Age in years; priorPneumonia and priorVaccine are binary and measured before time zero; no missing values.

### Time Zero Definition

The date eligibility is assessed, vaccination status is assigned, and outcome follow-up begins.

## Step 4: Assess Identifiability

### Exchangeability (No Unmeasured Confounding)

Known to hold conditional on age, priorPneumonia, and priorVaccine in this simulation. It would remain uncertain in real EHR data.

### Positivity (Overlap)

Model-based treatment propensities range approximately 0.08 to 0.91, with none below 0.05 or above 0.95. Practical overlap should still be checked before estimation.

### Consistency (Well-defined Intervention)

The simulated intervention is a single baseline vaccination decision. Real studies must distinguish product, dose, timing, and prior immunization history.

### No Interference (SUTVA)

Assumed in the teaching example. Transmission-mediated population effects could violate this assumption in a real vaccine study.

### Assessment of Causal Gap

Small and known in the simulation after adjustment; potentially material in real data because of residual confounding, selection, and measurement error.

### Modifications to Reduce Gap

Align eligibility, treatment assignment, and follow-up at time zero; enrich baseline confounders; validate treatment and outcome capture; restrict to common support; prespecify negative controls and quantitative bias analyses.

## Step 5: Define Statistical Estimand

### Causal Estimand

psi = E[Y^1] - E[Y^0], the average 12-month risk difference under vaccination versus no vaccination.

### Statistical Estimand

psi(P) = E_W{E(Y | A=1,W) - E(Y | A=0,W)}.

### Link to Causal Under Identification

The statistical and causal estimands coincide under consistency, conditional exchangeability given W, positivity, and no interference.

### Censoring Adjustment

None is needed in the complete teaching data. A real analysis would add inverse-probability-of-censoring adjustment or longitudinal TMLE.

## Step 6: Choose Estimator

### Primary Estimator

TMLE for the 12-month average risk difference.

### Nuisance Model Specification

Estimate Q(A,W)=E(Y | A,W) and g(W)=P(A=1 | W) with Super Learner using SL.glm, SL.glmnet, and SL.ranger.

### Variable Selection Strategy

Select W from the causal model, not by treatment-outcome p-values. Do not include post-baseline variables.

### Outcome-Blind Simulation Results

No formal repeated estimator simulation was performed. Feasibility diagnostics show adequate treatment overlap and no extreme propensity scores.

### Confidence Interval Method

Efficient-influence-function standard error and Wald 95% confidence interval.

### Prespecification Status

Teaching analysis plan fixed before inspecting the adjusted treatment-outcome estimate; not externally registered.

## Step 7: Sensitivity Analysis

### Primary Sensitivity Analysis Approach

Quantitative bias analysis for unmeasured confounding, plus alternative nuisance learners and propensity truncation checks.

### Sensitivity to Unmeasured Confounding

Assess whether residual confounding could shift the risk difference upward by approximately three percentage points.

### Sensitivity to Outcome Misclassification

Vary pneumonia-outcome sensitivity and specificity, including differential recording by vaccination status.

### Sensitivity to Selection Bias

Not present in the simulation. In real data, vary assumptions about death, disenrollment, and incomplete EHR capture.

### G-value (or E-value)

A bias of approximately +0.030 on the risk-difference scale would move the TMLE point estimate to the null. This is a descriptive robustness threshold, not a formal E-value.

### Negative Control Analyses

None are available in the simulated dataset. A real study should prespecify an unrelated outcome and/or exposure with a similar confounding structure.

## Step 8: Results & Interpretation

### Primary Result

TMLE risk difference = -0.0304; 95% CI -0.0461 to -0.0147.

### Unadjusted Result (for comparison)

Vaccinated risk 0.0719 versus unvaccinated risk 0.0643; crude risk difference +0.00758 and risk ratio 1.118, falsely suggesting harm.

### Interpretation Level

In the known simulation, adjustment recovers the protective direction and approaches the causal truth. A real-data causal interpretation would remain conditional on the identification assumptions.

### Comparison to Alternative Designs

Parametric g-computation risk difference -0.0328; Hajek IPW risk difference -0.0294; TMLE risk difference -0.0304; finite-simulation truth approximately -0.037. A randomized trial would remove baseline confounding, while an active-comparator/new-user design could improve exchangeability observationally.

### Key Limitations

Synthetic data, only three measured baseline variables, perfect measurement, no missingness or censoring, simplified treatment versions, and no population transmission effects.

### Conclusions

The crude association reverses the vaccine's true effect because higher-risk adults are preferentially vaccinated. After roadmap-guided adjustment, vaccination reduces 12-month pneumonia hospitalization risk by about three percentage points in this teaching simulation.

## Source lineage

- `../D/SegmentD_Roadmap.tex`
- `../../../../ops/materials/sessions/Session 1a/R example/pneumonia_vaccine_example.Rmd`
- `data/pneumonia_data.csv`
- `code/pneumonia_navigator_tmle.R`
- Causal Navigator, https://navigator.tao-rwd.com/
