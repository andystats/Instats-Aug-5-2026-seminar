# Module G facilitator guide: the analytics handoff in the Navigator

## What this segment adds

Module F ends with a completed study plan. Module G estimates the effect. This
segment shows the join between them: the Navigator writes the analysis
specification, the estimation runs on the facilitator's own machine, and only
summary output returns to the study record.

Budget 10 to 12 minutes for the live demonstration. It runs after the TMLE
slides, once participants have seen the four estimates, so the demonstration
shows where those numbers come from and where they go.

> **Synthetic teaching data only.** The cohort is fixed simulated data. It
> contains no patient records and is not evidence about clinical vaccine
> effectiveness.

## Evidence and language contract

The constraints from Module F apply unchanged. Keep them visible:

- Report the course-facing TMLE result as a risk difference of **-3.0
  percentage points**, 95% confidence interval **-4.6 to -1.5 percentage
  points**. Comparison estimates are g-computation **-3.28** and Hajek IPW
  **-2.94** percentage points.
- The **-4.04**-point figure is the value the generating model implies for the
  frozen cohort. Do not call it a superpopulation truth, and do not say an
  estimator recovered it.
- The fitted propensity range, approximately 0.077 to 0.909, is an overlap
  diagnostic for this fitted model and these observed covariates. It is not
  proof of structural positivity.
- Exchangeability, consistency, and no interference are stipulated for the
  exercise. The observed data cannot prove them.
- No E-value, no repeated-simulation bias or RMSE comparison.

## Before the session

1. Download the kit once, on the machine you will present from:
   <https://navigator.tao-rwd.com/kits/pneumonia-tmle/pneumonia-tmle.zip>
   Unzip it somewhere you can reach quickly from a terminal.
2. Run the analysis ahead of time so you are not waiting on it live:

   ```sh
   Rscript run_pneumonia_tmle.R
   ```

   It needs the `tmle`, `SuperLearner`, `glmnet`, `ranger`, and `jsonlite`
   packages and takes about two minutes. It writes `pneumonia-results.json`
   beside itself. Keep that file open in a text editor, ready to copy.
3. Open <https://navigator.tao-rwd.com/analytics/cross-sectional?source=upload&kit=pneumonia>
   in a clean browser profile. Confirm the **Kit files** panel and the **Bring
   your results back** panel are both visible.
4. Keep `data/pneumonia_dictionary.csv` open. It is the file that does the
   surprising part of the demonstration.

The live route needs no login. Attaching results to a saved study does need a
Pro account, so decide in advance which ending you want: see *Two endings*
below.

## Running the demonstration

### 1. Show the specification travelling, not the data (2 min)

Drop `pneumonia-dictionary.csv` into the **Data dictionary** panel. The column
mapping fills itself: treatment `A`, outcome `Y`, adjustment set `age`,
`priorPneumonia`, `priorVaccine`. The contrast menus offer the values the
dictionary declares.

Say what just happened: the tool has enough to write correct analysis code
without ever seeing a row of the cohort. The dictionary is metadata about
columns, not the data itself.

> **Ask the room.** What would you have had to send a statistician to get the
> same script written for you?

### 2. Export the analysis code (2 min)

Open **Offline R Markdown** and download or preview the notebook. Point out
that the column names in the generated code are the participants' own, taken
from the dictionary, and that the Navigator context from Module F appears as
comments at the top.

The kit also ships a ready-made `run_pneumonia_tmle.R` that computes the same
four estimators. Use the shipped script for the live run; the exported notebook
is what a participant would take back to their own data.

### 3. Run it at home, in the room (1 min)

Show the terminal command and the printed table. If you pre-ran it, show the
finished output instead of waiting:

```
    estimator risk_difference_pp
        Crude              0.758
G-computation             -3.276
    Hajek IPW             -2.936
         TMLE             -3.052
```

Say plainly which direction the crude comparison points, and why: people at
higher baseline risk were more likely to be vaccinated.

### 4. Bring back the summary, not the cohort (3 min)

Before pasting, open `pneumonia-results.json` and scroll it. It holds estimates,
counts, and diagnostics. It holds no rows. That is the point worth pausing on.

Paste it into **Bring your results back**. The four estimators render side by
side with the TMLE interval. Read the sign flip out loud one more time.

### 5. Close the loop (2 min)

Click **Attach**. The safe summary is written into the study record and Step 8
receives a draft interpretation, including a sentence noting that the
unadjusted and adjusted estimates disagree in direction. Open Step 8 and show
that the draft is editable prose, not a locked result.

> **Ask the room.** The draft says the assumptions decide whether this is a
> causal claim or an adjusted association. Which of your Module F entries would
> you revisit before signing your name to the causal reading?

## Two endings

Attaching writes to a saved study, which requires a Pro account.

- **With an account.** Load the pneumonia study first, then attach. The study
  name appears on the attach button, so participants see exactly which record
  is being written to.
- **Without an account.** Stop after the four-estimator table renders. Describe
  the attach step rather than performing it. Nothing else in the demonstration
  needs a login.

## If something goes wrong

| Symptom | Cause | What to do |
| --- | --- | --- |
| Mapping stays empty after the dictionary loads | Wrong file dropped, or the `role` column is missing | Confirm you dropped `pneumonia-dictionary.csv`, and that it has a `role` column naming `treatment`, `outcome`, and `confounder` |
| Download button stays greyed out | The contrast is incomplete | Set treated and comparator values; they must differ |
| "Could not parse as kit results" | The pasted text is not the file the run wrote | Paste the whole of `pneumonia-results.json`, not the printed console table |
| Amber "different study's id" warning | The results carry a study id that is not the loaded study | Expected if you exported `KIT_STUDY_ID` for another study. Either load that study or attach anyway, deliberately |
| R stops on a missing package | The estimation stack is not installed | `install.packages(c("tmle","SuperLearner","glmnet","ranger","jsonlite"))`, or present the pre-run output |
| Numbers differ slightly from the slides | A different R or package version | Say so plainly. The teaching point is the sign flip and the ordering, not the third decimal |

## What participants take away

Give participants the kit URL and the student guide. The kit README repeats the
walkthrough in five steps and lists the expected numbers, so a participant can
reproduce the whole segment later without the recording.

The transferable claim is not that TMLE gave -3.0 points. It is that a study
plan can specify an analysis precisely enough for the code to be written
elsewhere, for the run to happen where the data already live, and for only
summary output to come back.
