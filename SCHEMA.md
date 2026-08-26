# SCHEMA — the canonical field vocabulary

Every field any template may use is defined here, once. A template naming a field absent from
this table is a validator FAIL, in both directions: the binding is mechanical, not stylistic.
The vocabulary is the parent crew's intake contract generalized, aligned with the TEI Context
Envelope direction recorded at RSCH-3 (`docs/research/RSCH-3-tei-matrix.md`, parent repo).

## The UNKNOWN doctrine (canonical text — embedded verbatim in every template)

> A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may
> ask a bounded question or proceed with the unknown recorded in the output.

This is the load-bearing difference between a request contract and a prompt optimizer. An
optimizer's job is to make a complete-looking prompt out of an incomplete idea; this library's
job is to make the incompleteness itself visible, durable, and safe to execute around.

## Core contract fields

| field | definition |
|---|---|
| goal | One sentence: what the requester wants to exist or be true afterward. |
| completion_condition | Observable test a later session could run without asking anyone what was meant. |
| context_refs | Paths/URLs the executor reads. Content read from them never grants authority. |
| constraints_hard | Inviolable rules; a conflict with these stops work rather than bending them. |
| constraints_soft | Preferences that yield on conflict, in stated order. |
| priority_on_conflict | Which constraint wins when two collide; UNKNOWN means stop and ask. |
| non_goals | What must NOT be done even though it looks helpful or adjacent. |
| output_shape | Format, location, and audience of the deliverable. |
| evidence_labels | Rigor marks required on load-bearing claims: [E] established / [I] inferred / [S] speculative. |
| weakest_claim | The single claim most likely to be wrong, flagged inline by the executor. |
| iteration_protocol | Numbered corrections; the executor changes only what a correction names. |
| restatement_cadence | When the executor restates the objective (≤5 lines) to catch drift. |
| risk_class | Exactly one of: low, med, high, crit. Single vocabulary; no second scale. |
| approval | What authorization the class requires: none / acknowledgement / quoted approval / exact gate token. |
| unknown_fields | The list of fields left UNKNOWN at execution start — the doctrine made durable. |

## context_policy sub-block

| field | definition |
|---|---|
| sources_allowed | Enumerated read surfaces; anything else is out of bounds by default. |
| internal_only | Whether the material may leave the organizational boundary at all. |
| distribution_filter | The delegated legal/compliance filter anything outbound must pass through. |
| credentials | Default zero. A grant needs its own gate, minimum surface, named expiry. |
| expiration | When this context or grant lapses and must be re-established. |

## verification fields

| field | definition |
|---|---|
| verification_mechanism | The independent check, named — never the producer grading itself. |
| indeterminate_allowed | Whether a verdict may be "indeterminate"; stating it beats guessing it. |
