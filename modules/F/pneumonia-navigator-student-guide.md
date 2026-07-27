# Pneumonia vaccine Navigator guide

This is the completed, simplified version of the Module F worked example. The data are synthetic and are not evidence about real vaccine effectiveness.

## The question

Among 5,000 adults in a simulated health-system cohort, what is the effect of receiving a pneumococcal vaccine at baseline, compared with not receiving it, on the 12-month risk of hospitalization with pneumonia?

Target contrast: the average risk difference, E[Y^1] - E[Y^0].

## The eight Navigator steps

| Step | What we decided | What to check |
| --- | --- | --- |
| 1. Question | Baseline vaccination versus no vaccination; pneumonia hospitalization within 12 months | Are population, treatment, time zero, outcome, and contrast aligned? |
| 2. Model | Age and prior pneumonia/vaccination history are common causes of treatment and outcome | Did we adjust for common causes, not post-treatment variables? |
| 3. Data | 5,000 simulated people; 1,627 vaccinated; 334 events; no missingness or censoring | Can every protocol element be operationalized? |
| 4. Identification | Exchangeability given W, positivity, consistency, and no interference hold by construction | Which assumption would be least credible in real EHR data? |
| 5. Estimand | E_W{E(Y\|A=1,W) - E(Y\|A=0,W)} | Does the statistical quantity still answer the scientific question? |
| 6. Estimator | TMLE with Super Learner for Q and g; influence-function confidence interval | Were nuisance models and covariates prespecified? |
| 7. Sensitivity | Unmeasured confounding, outcome misclassification, selection/censoring, alternative learners | What size of causal gap would move the estimate to the null? |
| 8. Interpretation | Crude comparison points toward harm; adjusted estimate points toward protection | Is the wording no stronger than the assumptions allow? |

## Result reveal

| Analysis | Risk difference | Interpretation |
| --- | ---: | --- |
| Crude association | +0.76 percentage points | Vaccine appears harmful |
| G-computation | -3.28 percentage points | Protective after adjustment |
| Hajek IPW | -2.94 percentage points | Protective after adjustment |
| TMLE | -3.04 percentage points (95% CI -4.61 to -1.47) | Protective after adjustment |
| Finite-simulation truth | approximately -3.7 percentage points | Protective by construction |

The lesson is not that this simulated number is clinically correct. The lesson is that the same data can support opposite stories until the question, causal model, identification assumptions, estimand, and estimator are connected explicitly.

## Bring this to the Navigator

1. Open https://navigator.tao-rwd.com/navigator/1.
2. Work without login for the manual route.
3. Paste `pneumonia.dagitty.txt` through Step 2, **Bring your own**.
4. Use `causal-roadmap-pneumonia-worked-example.md` as the completed answer key.
5. Export the finished study as Markdown or plain text.

## One decision to defend

Choose one field and write two sentences:

1. What evidence makes the entry defensible?
2. What would make you revise it?
