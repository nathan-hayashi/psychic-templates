# fixture — second scale (control target: the vocabulary check)

## Purpose

Planted defect: a risk_class value outside low|med|high|crit. Fields are all canonical, so the
single-vocabulary check is the ONLY one that may fire on this file.

## Fields

```text
goal: <a valid canonical field>
risk_class: extreme
```

## Doctrine

A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.

## Verification

This file must FAIL the scale check and PASS the structure and field-binding checks.
