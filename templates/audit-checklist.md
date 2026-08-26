# audit-checklist — binary execution over a real corpus

## Purpose

The contract for auditing something that already exists: every check live, every verdict binary,
evidence is the artifact itself. Generalized from the parent's executed 71-check project audit.
The defining constraint travels with it: findings are reported, never silently corrected — an
audit that fixes as it goes has destroyed its own evidence.

## Fields

```text
goal: <what corpus is audited, in one sentence>
completion_condition: <every check row carries a binary verdict plus a citation; zero skips>
evidence_labels: <required marks on every verdict: [E] / [I] / [S]>
weakest_claim: <flagged inline where it weakens the audit>
iteration_protocol: <numbered corrections; the auditor changes only what a correction names>
restatement_cadence: <objective restated in ≤5 lines before each major section>
output_shape: <scan-optimized .md, tables over prose, stable check IDs>
non_goals: <fixing findings; escalating checks for input mid-run>
unknown_fields: <every field above left blank, listed>
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Worked example

```text
goal: Audit every claim the README makes against the tree it describes.
completion_condition: One row per claim; each row PASS or FAIL with the file and line that proves it; zero rows skipped.
evidence_labels: [E] for file citations, [I] for cross-file inference, [S] forbidden in verdicts
weakest_claim: flagged inline
iteration_protocol: numbered corrections only
restatement_cadence: top of each section
output_shape: docs/audit/README-AUDIT.md, one table per README section
non_goals: editing the README during the audit
unknown_fields: none
```

## Verification

Valid when the completion condition forbids skips explicitly, non_goals contains the
report-do-not-correct rule, and every verdict in the executed audit carries an evidence label.
