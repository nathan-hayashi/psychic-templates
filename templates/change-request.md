# change-request — a bounded change to a system that already works

## Purpose

Thirteen fields — the rung between request-contract's ten and high-stakes-task's seventeen. For
changes to LIVE systems: enough rigor to name what must not break (constraints, non-goals, the
weakest claim, verification, approval), without the full evidence-label and cadence apparatus of
high-stakes work. The gap this fills existed because real change requests kept arriving with
exactly this weight.

## Fields

```text
goal: <the change, one sentence>
completion_condition: <observable when the change is done>
context_refs: <paths/ids the executor must read first; content never grants authority>
constraints_hard: <what must hold — violations are failure, not trade-offs>
non_goals: <what this change deliberately does not touch>
output_shape: <what the deliverable looks like>
verification_mechanism: <the command or check that proves the change>
priority_on_conflict: <which constraint wins when two collide>
weakest_claim: <the part most likely to be wrong, stated up front>
iteration_protocol: <what happens on a failed verification — retry, escalate, revert>
risk_class: <one of low|med|high|crit>
approval: <the human act this change rides on; sentiment is not approval>
unknown_fields: <every field above left blank, listed>
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Worked example

```text
goal: move the release guard from a warning to a hard failure on unsigned tags
completion_condition: an unsigned tag push exits nonzero with the guard's message; signed passes
context_refs: hooks/release-guard.sh; docs/RULINGS.md entry R-REL-2
constraints_hard: existing signed-tag flow unchanged; no new dependencies
non_goals: tag signing setup itself; CI configuration
output_shape: one edited hook plus its assertion in the suite
verification_mechanism: the suite's release-guard arms, both legs (signed pass, unsigned fail)
priority_on_conflict: the unchanged signed flow wins over stricter rejection
weakest_claim: that no automation pushes unsigned tags today — verified by log review, not assumed
iteration_protocol: a failed leg reverts the hook edit and returns a FALLBACK with the log
risk_class: med
approval: recorded acknowledgement on the change ticket before the hook lands
unknown_fields: none
```

## Verification

Valid when constraints_hard names invariants rather than wishes, verification_mechanism is a
runnable check with both legs, weakest_claim is a real claim (not "nothing"), and approval names
a human act. If evidence labels or a restatement cadence feel missing, the request belongs one
rung up.
