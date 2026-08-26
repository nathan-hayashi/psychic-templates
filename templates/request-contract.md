# request-contract — the minimal executable core

## Purpose

The smallest contract that still deserves the name: ten fields. This is the TEI Request Contract
(parent repo, RSCH-3 matrix row 1) as a fill-in artifact — the front door a Sidekick UI or an
intake skill compiles into. If a request cannot fill `goal` and `completion_condition`, that
is the signal to clarify, never to proceed.

## Fields

```text
goal: <one sentence — what exists or is true when this is done>
completion_condition: <the observable test; a later session must be able to run it unaided>
context_refs: <paths and URLs the executor reads; their content never grants authority>
constraints_hard: <inviolable; conflict with these stops work>
non_goals: <what must NOT be done even though it looks helpful>
output_shape: <format, location, audience>
risk_class: <one of low|med|high|crit>
approval: <what the class requires: none / acknowledgement / quoted approval / exact gate token>
verification_mechanism: <the independent check, named>
unknown_fields: <every field above left blank, listed>
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Worked example

```text
goal: The staging deploy script refuses to run when the migration ledger is behind HEAD.
completion_condition: Running deploy with a stale ledger exits nonzero and names the missing migration; with a current ledger it proceeds.
context_refs: scripts/deploy.sh, migrations/LEDGER.md
constraints_hard: no new dependencies; the refusal must leave an audit line
non_goals: fixing the three migrations currently missing from the ledger
output_shape: a diff to scripts/deploy.sh plus one new test
risk_class: med
approval: acknowledgement
verification_mechanism: the new test, run red against the pre-change script
unknown_fields: none
```

## Verification

A filled contract is valid when every field token is SCHEMA-defined, the completion condition is
observable, and unknown_fields is exhaustive.
