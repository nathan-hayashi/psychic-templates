# AUDIT — psychic-templates vs promptbuilder.cc

Status: SIDE-0 acceptance artifact. Evidence: promptbuilder.cc homepage, fetched 2026-08-26
(unauthenticated), quoted verbatim below `[E]`; this library's own files `[E]`. Criteria were
fixed before any scoring (the parent's C-18 rule); no dimension was added or dropped afterward.

## Restatement (≤5 lines)

Objective: a structured head-to-head between this template library and promptbuilder.cc — the
operator's requested hard audit, serving as SIDE-0's acceptance test. Criteria table first,
per-dimension verdicts with evidence, then a competitive-advantage verdict. Findings are
reported as found; nothing is scored by sympathy in either direction.

## A. The ten dimensions, fixed before scoring

1. Contract completeness · 2. Unknown-input handling · 3. Clarification ceiling · 4. Evidence
discipline · 5. Verification & audit · 6. Risk classing & approval · 7. Data boundary & context
policy · 8. Iteration & versioning UX · 9. Speed & ease of first use · 10. Openness &
machine-checkability.

## B. Head-to-head

| # | Dimension | promptbuilder.cc `[E]` | psychic-templates `[E]` | Verdict |
|---|---|---|---|---|
| 1 | Contract completeness | Free-text prompts per target model; no evidence of structured fields (constraints, non-goals, completion conditions, risk levels) — "internal structure remains opaque" | 22 SCHEMA-defined fields; validator fails any template naming an undefined field, both directions | **OURS** |
| 2 | Unknown-input handling | Fills gaps by assumption, then discloses: "See the assumptions the engine made while writing your prompt" | The UNKNOWN doctrine, embedded verbatim in all 4 templates and mechanically asserted; `unknown_fields` makes the gaps durable | **OURS** — their assumptions display is honest, but disclosure of a guess is not the absence of one |
| 3 | Clarification ceiling | Optimizer "asks up to three quick questions" then regenerates | The parent intake law: at most three questions, each only if answers change the work | **TIE** — independent convergence on the same ceiling |
| 4 | Evidence discipline | None identified on the page | `evidence_labels` ([E]/[I]/[S]) + mandatory `weakest_claim`, required fields in the audit and high-stakes templates | **OURS** |
| 5 | Verification & audit | "None identified. No mention of output validation, confidence scoring, or audit trails" | `verification_mechanism` (independent, named) + `indeterminate_allowed`; the library itself ships a validator with negative controls | **OURS** |
| 6 | Risk classing & approval | Absent | `risk_class` (low/med/high/crit, single vocabulary) routing to `approval` (none → exact gate token) | **OURS** |
| 7 | Data boundary & context policy | SaaS-only; no export option mentioned; prompts run inside their Assistant against third-party models | A standalone `context-policy` template: `sources_allowed`, `internal_only`, `distribution_filter`, `credentials` default zero, `expiration` | **OURS** |
| 8 | Iteration & versioning UX | "Every refine is tracked on a timeline. Compare where you started, and revert to any earlier version" + contextual follow-up prompts | Numbered-corrections protocol as a field; version history only via git | **THEIRS** — purpose-built timeline UX beats a protocol in prose |
| 9 | Speed & ease of first use | "model-ready prompt in seconds"; free tier 5 credits/month, no card; targets Grok/Gemini/GPT/DeepSeek | A contract must be filled by a person who knows what they want | **THEIRS** — by design, and the cost is the point |
| 10 | Openness & machine-checkability | Closed SaaS engine; credit-metered ($9/$19/$49 per month tiers); no export named | Plain markdown files; a shell validator anyone can run; no service dependency | **OURS** |

## C. Divergence from the RSCH-2 dive, recorded

The RSCH-2 dive (parent, Dive 5) listed "team sharing" in promptbuilder's feature set. Today's
homepage states the opposite: no team collaboration yet — "on the roadmap". Both reads carry the
same retrieval date; the dive most plausibly summarized an aspirational marketing list. Per the
report-do-not-correct law the dive text stands as written; this row is the flag, and any future
RSCH-2 correction is the operator's numbered call. `[E]` for today's quote, `[I]` for the
explanation of the mismatch.

## D. Verdict

**7 OURS / 2 THEIRS / 1 TIE — and the honest frame is segmentation, not domination.**
promptbuilder.cc is a good prompt optimizer: it makes an incomplete idea look complete, fast,
for casual stakes. This library exists for the opposite regime, where the expensive failure is
exactly a complete-looking artifact hiding guessed-in requirements. The RSCH-2 preliminary claim
is **CONFIRMED with evidence**: the optimizer's own homepage shows zero verification, audit,
risk, or boundary surface — it has no reason to force those questions, and it doesn't. Where
stakes are low the two tools are complementary; where they are high, an optimizer's core move
(fill by assumption) is this library's defined defect.

## E. Weakest claim, flagged

`[I]` Every promptbuilder observation above is homepage-only and unauthenticated: no account was
created, so the logged-in artifact structure is unobserved. A structured-fields editor behind the
login would overturn dimension 1 and soften 5. What would settle it: one authenticated session
inspecting a saved prompt's anatomy. Second unknown: per-generation credit cost (pricing lists
credits, not cost per prompt).

## F. Verify

- Dimension rows: `grep -c '^| [0-9]' docs/AUDIT-vs-promptbuilder.md` → 10.
- Quotes traceable to the 2026-08-26 homepage fetch; retrieval date stated in the header.
- Library-side claims runnable: `./scripts/validate-templates.sh` green proves rows 1, 2, 5, 10's
  mechanical assertions.
