# Module F workshop review and publication notes

## Publication assessment

Module F is suitable as the workshop's central participant activity after the
new facilitator guide, pre-result participant decision log, completed answer
key, and Beamer files are synchronized.

The strongest instructional format is a **co-authored audit**: the facilitator
operates the live Navigator while participants make and defend the decisions.
This keeps the workshop active without requiring every participant to type all
eight steps into the interface within 55 minutes.

The direct Module G handoff is **not publication-ready** until Module G is
aligned to the same dataset, estimand, and results.

## Recommended canonical Markdown roles

| File | Audience | Publication role |
| --- | --- | --- |
| `facilitator-live-demo.md` | Facilitators | 55-minute run-of-show, evidence contract, result reveal, and recovery plan |
| `pneumonia-navigator-student-guide.md` | Participants | Pre-result workbook and decision log; no adjusted answer reveal |
| `causal-roadmap-pneumonia-worked-example.md` | Facilitators and post-workshop participants | Completed eight-step answer key released after the interpretation exercise |
| `WORKSHOP_REVIEW.md` | Maintainers | QA record, unresolved cross-module work, and publication checklist |

The `.new.md` files in this build directory are publication-ready replacements
for the first three roles. They deliberately do not overwrite the current
files.

## Pedagogical findings incorporated

- The central activity now runs throughout the session rather than appearing
  only in the final five minutes.
- Participants make a decision before each prepared entry appears.
- Step 4 is the main audit pause: choose the weakest assumption, name supporting
  evidence, and propose a design response if it fails.
- The final deliverable uses Module E's **accept, correct, or reject** language.
- Each participant must identify evidence, a revision trigger, and the
  downstream consequence of changing one field.
- The adjusted result is held until Steps 1-7 are locked.
- The participant guide contains blank result rows rather than an answer reveal.
- The completed worked example is explicitly labeled as a post-activity answer
  key.
- If the live site fails, the workshop can continue from screenshots because
  the learning objective is the audit, not interface completion.

## Reproducibility and claim audit

The following are archived and reviewable:

- fixed synthetic dataset;
- five-node, nine-edge DAG specification;
- R analysis script;
- crude, g-computation, Hajek IPW, and TMLE outputs; and
- fitted treatment-model diagnostics and package versions.

The following are not archived in Module F:

- the data-generator code; and
- an intervention-level causal truth.

Publication language must therefore not say that:

- the estimator recovered a known truth;
- the DAG is verified against the generator;
- exchangeability, consistency, or no interference were proven;
- the fitted propensity-score range proves structural positivity; or
- estimator bias or RMSE was evaluated.

The course-facing numerical convention is:

| Analysis | Risk difference |
| --- | ---: |
| Crude association | +0.76 percentage points |
| Parametric g-computation | -3.28 percentage points |
| Hajek IPW | -2.94 percentage points |
| TMLE | -3.0 percentage points (95% CI -4.6 to -1.5) |

No intervention-truth row should appear. No E-value should be reported.

## Remaining cross-module work

### Module D

1. Module D currently describes the pneumonia population as adults aged 65 or
   older. Module F's fixed dataset has age centered at 65 and is not restricted
   to age 65+. Align the wording before presenting the modules as one continuous
   case.
2. Module D teaches a nine-step roadmap, while the live Navigator uses eight
   operational steps. Add or retain an explicit mapping:

   - Navigator Step 1 records the scientific question and causal contrast;
   - Navigator Steps 2-7 correspond to model, data, identification, statistical
     estimand, estimator, and sensitivity; and
   - Navigator Step 8 records results and interpretation.

### Module G

Module G currently uses a different simulation and different numerical results.
It must be revised to use Module F's fixed dataset and outputs, or it must be
clearly described as a separate example. Until that decision is implemented,
do not say that Module G directly implements the estimator chosen in this
specific Navigator record.

### Module E

Module F now deliberately reuses Module E's **accept, correct, or reject**
disposition language. Preserve that phrase in both modules so participants
experience one continuous audit workflow.

## Format and accessibility findings

- The PowerPoint decks convert cleanly to the established 16:9 Beamer visual
  system; the palette already matches the slate-and-blue Module D treatment.
- The earlier PowerPoint-derived PDFs are rasterized and non-searchable. Publish
  the new Beamer PDFs alongside the Markdown versions so text remains available
  in an accessible, searchable format.
- Keep the Navigator URL visible in both facilitator and participant materials:
  <https://navigator.tao-rwd.com/navigator/1>.
- Full-screen UI captures become difficult to read when reduced to half a
  slide. Use them as orientation or fallback evidence, and pair them with
  enlarged text or focused crops for the field being discussed.
- Do not rely on accent color alone to distinguish supported and unsupported
  claims; retain explicit labels.

## Publication checklist

- [ ] Approve and promote the three `.new.md` replacements to their canonical
      filenames.
- [ ] Confirm the facilitator and participant Beamer decks use the same wording,
      result values, and evidence limits as the Markdown.
- [ ] Confirm the participant PDF and GitHub page do not reveal adjusted results
      before the workshop checkpoint.
- [ ] Confirm the answer key is labeled for release after the activity.
- [ ] Normalize or verify image formats before the final LaTeX build.
- [ ] Render every final PDF page and inspect screenshot legibility, clipping,
      equations, links, and result labels.
- [ ] Resolve Module D's age wording.
- [ ] Add the Module D nine-step to Navigator eight-step mapping.
- [ ] Align Module G or relabel it as a separate example.
- [ ] Update GitHub Pages links so the participant workbook is primary and the
      completed worked example is clearly marked as the answer key.
- [ ] Verify Box and GitHub copies by checksum after the final files are chosen.
