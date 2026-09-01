# quick-brief — the smallest contract that still refuses to guess

## Purpose

Four fields. For requests too small for request-contract's ten but too load-bearing for a bare
chat message — a rename, a one-file fix, a question whose answer will be acted on. The floor of
the ladder: below this, incompleteness is invisible by construction.

## Fields

```text
goal: <one sentence, concrete>
completion_condition: <observable — a later session could check it without asking anyone>
risk_class: <one of low|med|high|crit>
unknown_fields: <every field above left blank, listed>
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Worked example

```text
goal: rename the metrics fence helper to match its sibling's naming
completion_condition: grep finds zero old-name references; the suite is green
risk_class: low
unknown_fields: none
```

## Verification

Valid when the completion condition is observable rather than a synonym of the goal, and
risk_class is one of the four vocabulary values. A quick-brief at high or crit is a signal the
request has outgrown this rung — climb the ladder instead of stretching it.
