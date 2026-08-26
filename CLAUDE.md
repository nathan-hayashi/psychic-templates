# psychic-templates — law

Prompt-contract template library. Born 2026-08-26 under the parent HELIX program's SIDE-0 gate
(psychic-crew, a sibling of this repo). PRIVATE at creation; publication is its own future gate.

## Binding rules
- **Evidence labels.** Load-bearing claims carry `[E]` (established: the file or fetch itself),
  `[I]` (inferred), or `[S]` (speculative). Every deliverable flags its weakest claim inline.
- **Validate before claiming.** `./scripts/validate-templates.sh` green is the definition of
  working; a claim without a fresh run is a guess.
- **Gate law.** Phases close only on the exact operator token recorded in `GATES.md`. Commits are
  fronted by `./scripts/gate-guard.sh "<token>"`. Approval is never inferred from sentiment.
- **One risk vocabulary.** `low | med | high | crit` — the parent's severity table, unchanged.
  Inventing a second scale is a defect, not a customization (the parent's CR-026 lesson).
- **The UNKNOWN doctrine** (canonical text lives in `SCHEMA.md`, embedded verbatim in every
  template): a blank field is never guessed into existence.
- **No absolute machine paths** in tracked files; resolve through `$HOME` or the repo root.
- **No credentials, ever** — zero is the default posture, inherited from the parent's
  secrets contract (R-SEC-1). This repo has no granting gate.
