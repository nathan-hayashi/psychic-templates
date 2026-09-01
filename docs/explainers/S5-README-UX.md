# S5-README-UX (templates leg), explained plainly

## What changed

The README got a count badge (bound, not decorative — the extractor now reads badge URLs too),
the quickstart lost its machine-local `~/projects` assumption, and a "What is not asserted"
section states plainly that the suite binds structure and counts, never fitness-for-purpose.
The old first-occurrence count binding became every-occurrence with a planted-conflict control.

## Why

A badge above a bound line is exactly how a first-occurrence extractor gets silently retargeted
— the badge's number becomes "the count" and the prose rots underneath. Every-occurrence closes
that hole before the badge exists to open it.

## Verify it yourself

```
./scripts/validate-templates.sh | tail -5
grep 'badge/templates' README.md      # the badge number rides the same binding
```

## What could break, and what catches it

Badge and prose disagree → one arm names both values. The planted probe proves a conflicting
badge is seen, every run.
