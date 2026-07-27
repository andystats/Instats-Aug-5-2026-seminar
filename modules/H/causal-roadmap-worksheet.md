# Causal roadmap worksheet

Use one version of this worksheet per causal question. Complete it before
analysis, update it when evidence changes, and keep it beside the code and
results.

## Study record

- Study or project:
- Roadmap version:
- Date:
- Decision owner:
- Reviewers:
- Link to protocol, registration, or analysis repository:

For every step, record the **decision**, the **evidence**, the **remaining
uncertainty**, and the **revision trigger**.

## 1. Specify the research question

Define the population, treatment or exposure strategies, outcome, time zero,
follow-up, and causal contrast. Write the target-trial protocol when that
framing applies.

- Decision:
- Evidence or source:
- Remaining uncertainty:
- Revision trigger:

## 2. Specify the causal model

State the causal structure that connects treatment, outcome, baseline causes,
post-treatment variables, selection, measurement, and missingness. Attach a
DAG or another explicit model.

- Decision:
- Evidence or source:
- Remaining uncertainty:
- Revision trigger:

## 3. Define the causal parameter

Write the counterfactual quantity that answers the question. State the
intervention, population, outcome summary, contrast, and time horizon.

- Decision:
- Evidence or source:
- Remaining uncertainty:
- Revision trigger:

## 4. Describe the observed data

Map each protocol element and model variable to the available data. Record
definitions, timing, provenance, measurement limitations, and missingness.

- Decision:
- Evidence or source:
- Remaining uncertainty:
- Revision trigger:

## 5. Assess identifiability

State the assumptions needed to connect the causal parameter to the observed
data. Consider exchangeability, positivity, consistency, interference,
selection, measurement, and missingness as relevant.

- Identification result:
- Evidence or source:
- Weakest assumption:
- Design response if it fails:
- Revision trigger:

## 6. Define the statistical estimand

Write the observed-data quantity to be estimated, including scale,
standardization population, time horizon, and any censoring or competing-event
handling.

- Decision:
- Evidence or source:
- Remaining uncertainty:
- Revision trigger:

## 7. Choose and implement an estimator

Choose a method that targets the estimand and fits the data structure. Prestate
nuisance-model strategy, variance estimation, diagnostics, and software.

- Decision:
- Evidence or source:
- Diagnostics required:
- Failure or revision trigger:

## 8. Conduct sensitivity analyses

Match each important vulnerability to an analysis, bound, negative control,
alternative specification, or transparent limitation.

- Vulnerability:
- Planned analysis or design response:
- Result that would change the interpretation:
- Remaining uncertainty:

## 9. Interpret results in context

Connect the estimate back to the original causal question. State what the
analysis supports, what it does not support, and which uncertainties remain.

- Main claim:
- Important numerical result:
- Key assumptions supporting the claim:
- Claim limit:
- Decision or next action:
- Evidence that would change the conclusion:

## Navigator mapping

The literature roadmap above has nine steps. The workshop's Causal Navigator
groups the same work into eight operational steps:

| Navigator step | Worksheet content |
| --- | --- |
| 1. Causal question | Research question, target trial, and causal contrast |
| 2. Causal model | Causal model |
| 3. Observed data | Observed-data mapping |
| 4. Identifiability | Identification assumptions and audit |
| 5. Statistical estimand | Statistical estimand |
| 6. Estimator | Estimator and diagnostics |
| 7. Sensitivity analysis | Sensitivity plan |
| 8. Results | Results, interpretation, and claim limits |

## Final consistency check

- [ ] The population, treatment strategies, outcome, time zero, and follow-up
      agree across the question, estimand, estimator, and interpretation.
- [ ] Every key assumption has evidence, an uncertainty statement, or both.
- [ ] The estimator targets the stated estimand.
- [ ] Diagnostics are tied to decisions rather than reported as decoration.
- [ ] Sensitivity analyses address named vulnerabilities.
- [ ] The final claim does not outrun the design or assumptions.
- [ ] The audit log identifies who proposed, reviewed, and changed each
      consequential entry.
