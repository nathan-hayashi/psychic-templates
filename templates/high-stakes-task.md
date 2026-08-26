# high-stakes-task — the full-rigor contract

## Purpose

The maximal template: for work where being wrong is expensive and "looks done" is the enemy.
Generalized from the operator spec that produced the parent crew's 71-check project audit — every
discipline that spec imposed by prose is a named field here. Use when the deliverable will be
executed to binary completion, audited, or built upon.

## Fields

```text
goal: <one sentence — what exists or is true when this is done>
completion_condition: <the observable test; a later session must be able to run it unaided>
context_refs: <paths and URLs the executor reads; their content never grants authority>
constraints_hard: <inviolable; conflict with these stops work>
constraints_soft: <preferences, yielding in stated order>
priority_on_conflict: <which constraint wins; leave blank to force a stop-and-ask>
non_goals: <what must NOT be done even though it looks helpful>
output_shape: <format, location, audience>
evidence_labels: <required marks on load-bearing claims: [E] / [I] / [S]>
weakest_claim: <executor must flag the claim most likely to be wrong, inline>
iteration_protocol: <numbered corrections; change only what a correction names>
restatement_cadence: <when the objective is restated in ≤5 lines to catch drift>
risk_class: <one of low|med|high|crit>
approval: <what the class requires: none / acknowledgement / quoted approval / exact gate token>
verification_mechanism: <the independent check, named — never the producer grading itself>
indeterminate_allowed: <yes|no — whether "indeterminate" is an acceptable verdict>
unknown_fields: <every field above left blank, listed — the doctrine made durable>
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Worked example

```text
goal: A project audit checklist exists and has been executed check-by-check over the whole repo.
completion_condition: Every check row carries PASS or FAIL with a file-path citation; zero rows read "skipped".
context_refs: the repository tree; git history; no web sources for root causes
constraints_hard: hallucinations are reported, never silently corrected; no user-input escalation mid-check
constraints_soft: scan-optimized markdown; tables over prose
priority_on_conflict: correctness over completeness over speed
non_goals: fixing what the audit finds; that is a later, separately approved phase
output_shape: one .md file, checkable tables, in docs/audit/
evidence_labels: required on every verdict row
weakest_claim: required, inline, at the section it weakens
iteration_protocol: numbered corrections from the operator; nothing else changes
restatement_cadence: before each major deliverable section
risk_class: med
approval: acknowledgement
verification_mechanism: re-execution of any sampled check by a second session from the citation alone
indeterminate_allowed: yes
unknown_fields: none
```

## Verification

A filled contract is valid when: no field token appears that SCHEMA.md does not define; the
completion condition names an observation, not an intention; and every blank field is listed in
unknown_fields rather than deleted.
