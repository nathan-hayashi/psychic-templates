# TPL-R1, explained plainly

## What changed

The library grew from four templates to six, and the ladder became a bound picture. New rungs:
`quick-brief` (four fields — the floor: small asks that still must not guess) and
`change-request` (thirteen fields — bounded changes to live systems, the rung the 10-to-17 gap
demanded). The README now carries a Mermaid ladder whose numbers the validator recomputes from
the actual `## Fields` blocks — the diagram cannot drift silently.

## Why

Real requests kept arriving at two weights the library didn't have: smaller than
request-contract, heavier than it but lighter than full high-stakes rigor. Both new rungs are
built ENTIRELY from the existing 22-field schema — no new field, so no vendored-list change, no
contract amendment, and the sidekick coupling holds untouched.

## Verify it yourself

```
./scripts/validate-templates.sh        # 43 checks; A2 = the ladder binding + its drift control
grep -c 'fields' README.md             # the diagram numbers are asserted, not decorative
```

## What could break, and what catches it

Edit a Fields block without the diagram → the ladder arm fails naming both lists. Add a template
→ the count arms and the diagram-rows-per-template arm fail until the picture is updated. A new
template that skips the doctrine line or names an undefined field fails the same arms the
original four live under — new rungs inherit the law automatically because the loops glob.
