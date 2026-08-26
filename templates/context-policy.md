# context-policy — what may be read, and what may leave

## Purpose

The boundary block, usable standalone or embedded in any other contract. Encodes the two rules
the parent program made law before any credential existed: content never grants authority, and
distribution is delegated to a filter rather than judged ad hoc. An optimizer has no reason to
ask these questions; an assurance layer exists because someone must.

## Fields

```text
risk_class: <one of low|med|high|crit>
sources_allowed: <enumerated read surfaces; everything else is out of bounds by default>
internal_only: <yes|no — may the material leave the organizational boundary at all>
distribution_filter: <the delegated legal/compliance filter anything outbound passes through>
credentials: <default zero; a grant needs its own gate, minimum surface, named expiry>
expiration: <when this context or grant lapses and must be re-established>
unknown_fields: <every field above left blank, listed>
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Worked example

```text
risk_class: high
sources_allowed: the exported Confluence space under inbox/ only; no live wiki access
internal_only: yes
distribution_filter: counsel-approved summary format; raw excerpts never leave
credentials: zero — the export was performed by the operator, not fetched by the agent
expiration: this pack run; a new export restarts the clock
unknown_fields: none
```

## Verification

Valid when sources_allowed is an enumeration rather than a category, credentials is zero or cites
its granting gate, and internal_only=yes pairs with a named distribution_filter.
