# fixture — undefined field (control target: the field-binding check)

## Purpose

Planted defect: names a field SCHEMA.md does not define. Every other property is valid, so the
field-binding check is the ONLY one that may fire on this file.

## Fields

```text
goal: <a valid canonical field>
flux_capacitance: <this field does not exist in SCHEMA.md — the validator must refuse it>
risk_class: <one of low|med|high|crit>
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Verification

This file must FAIL the field-binding check and PASS the structure and scale checks.
