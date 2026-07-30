# Causal Roadmaps with AI

Companion materials for the **INStats online seminar on 5 August 2026**.

Welcome from **Kathryn, Andy, Robert, and Auriane**.

This repository contains the seminar slides, worked examples, code, data, and
participant materials. Materials will be added as they are finalized.

## Seminar home

The student-facing course page is:

**[andystats.github.io/Instats-Aug-5-2026-seminar](https://andystats.github.io/Instats-Aug-5-2026-seminar/)**

## Schedule (August 5, 2026)

The seminar runs 12:00–5:00 pm ET (10:00 am–3:00 pm MT). Robert joins at
2:00 pm ET, so his examples (Module B) run directly after the Roadmap.

| # | Session | MT | ET | Module | Lead |
| --- | --- | --- | --- | --- | --- |
| 1 | Welcome and Intro | 10:00–10:20 | 12:00–12:20 | [A](modules/A/) | Kathryn (MC) and Andy |
| 2 | Foundations | 10:20–11:05 | 12:20–1:05 | [C](modules/C/) | Kathryn |
| | *Break* | 11:05–11:15 | 1:05–1:15 | | |
| 3 | The Roadmap | 11:15–12:00 | 1:15–2:00 | [D](modules/D/) | Andy |
| 4 | Robert's examples | 12:00–12:25 | 2:00–2:25 | [B](modules/B/) | Robert |
| 5 | Audit-First AI | 12:25–12:45 | 2:25–2:45 | [E](modules/E/) | Auriane and Kathryn |
| | *Lunch break* | 12:45–1:15 | 2:45–3:15 | | |
| 6 | Live Navigator | 1:15–2:10 | 3:15–4:10 | [F](modules/F/) | Andy, with Auriane on screen share |
| | *Break* | 2:10–2:20 | 4:10–4:20 | | |
| 7 | TMLE | 2:20–2:55 | 4:20–4:55 | [G](modules/G/) | Andy |
| 8 | Close | 2:55–3:00 | 4:55–5:00 | [H](modules/H/) | Kathryn (MC) and Andy |

## Modules

Listed in the run of day. Folder letters are stable: Module B kept its
letter when it moved after the Roadmap to fit Robert's schedule.

| Module | Focus | Materials |
| --- | --- | --- |
| A | Welcome + Intro | [Open Module A](modules/A/) |
| C | Foundations | [Open Module C](modules/C/) |
| D | The Roadmap | [Open Module D](modules/D/) |
| B | Example with Robert Platt *(forthcoming)* | [Open Module B](modules/B/) |
| E | Audit-First AI | [Open Module E](modules/E/) |
| F | Live Navigator workshop | [Open Module F](modules/F/) |
| G | TMLE live walkthrough + technical supplement | [Open Module G](modules/G/) |
| H | Wrap-up + participant kit | [Open Module H](modules/H/) |

Module F is the central participant workshop: learners carry one synthetic
pneumonia-vaccine study through all eight Causal Navigator steps. Module G then
uses the same cohort, estimand, and adjustment set for a live TMLE walkthrough
and an optional technical supplement. Module H closes the seminar with a
next-study commitment, reusable roadmap and audit-log templates, and links to
the completed workshop example.

## Repository structure

```text
.
├── index.html          # GitHub Pages welcome page
├── styles.css          # Shared site styles
├── assets/             # Images used by the public page
└── modules/
    ├── A/ ... H/       # Slides, notes, code, data, and exercises by module
```

Materials are released under the [MIT License](LICENSE), unless a file states
otherwise.
