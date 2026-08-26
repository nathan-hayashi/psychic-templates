#!/usr/bin/env bash
# validate-templates.sh — the TPL assertion layer, born WITH the scaffold (the parent's L0 lesson:
# controls travel with the thing they control from day one, or they trail it forever).
# One script, house counters. The negative controls run the SAME check functions against planted
# fixtures and demand failure — a checker never seen failing proves nothing (the parent has twice
# caught its own author only because its controls actually fire).
set -uo pipefail
cd "$(dirname "$0")/.."
P=0; F=0
ok () { P=$((P+1)); printf '  [PASS] %s\n' "$1"; }
no () { F=$((F+1)); printf '  [FAIL] %s\n' "$1"; }

# Needles assembled from fragments so this file never contains what it hunts (house pattern).
ABS=$(printf '/%s/' home)
CRED1="gh""p_"; CRED2="xox""b-"; CRED3="AKI""A"; CRED4="BEGIN ""PRIVATE KEY"
DOC='A field left blank is UNKNOWN and stays UNKNOWN: the executor never fills it by guess — it may ask a bounded question or proceed with the unknown recorded in the output.'

canon=$(grep -oE '^\| [a-z_]+ \|' SCHEMA.md | tr -d '| ' | grep -v '^field$' | sort -u)
ncanon=$(grep -c . <<<"$canon")
[[ "$ncanon" =~ ^[0-9]+$ ]] || ncanon=0

chk_structure () { # $1=file → 0 iff all four required sections present
  local f="$1" h
  [ -f "$f" ] || return 1
  for h in '## Purpose' '## Fields' '## Doctrine' '## Verification'; do
    grep -qF "$h" "$f" || return 1
  done
  return 0
}
chk_fields () { # $1=file → 0 iff every field token used is canonical (vacuous use is a fail)
  local f="$1" used undef
  used=$(grep -oE '^[a-z_]+:' "$f" | tr -d ':' | sort -u)
  [ -n "$used" ] || return 1
  undef=$(comm -23 <(printf '%s\n' "$used") <(printf '%s\n' "$canon"))
  [ -z "$undef" ]
}
chk_scale () { # $1=file → 0 iff every concrete risk_class value is in the single vocabulary
  local f="$1" bad
  bad=$(grep -E '^risk_class:' "$f" | grep -vF '<' | grep -vE ':[[:space:]]*(low|med|high|crit)[[:space:]]*$')
  [ -z "$bad" ]
}

echo "== A. structure =="
for s in scripts/*.sh; do bash -n "$s" 2>/dev/null || no "syntax error in $s"; done
ok "all shell files parse"
[ "$ncanon" -ge 20 ] && ok "SCHEMA defines $ncanon fields (non-vacuous)" || no "SCHEMA vacuous: $ncanon fields"
tlist=$(ls templates/*.md 2>/dev/null)
tcount=$(grep -c . <<<"$tlist")
[[ "$tcount" =~ ^[0-9]+$ ]] || tcount=0
[ "$tcount" -eq 4 ] && ok "exactly 4 templates present" || no "template count $tcount != 4"
for f in templates/*.md; do
  chk_structure "$f" && ok "structure: $f" || no "structure incomplete: $f"
done

echo "== B. field binding, both directions =="
for f in templates/*.md; do
  chk_fields "$f" && ok "fields canonical: $f" || no "undefined field in $f"
done
alltok=$(cat templates/*.md | grep -oE '^[a-z_]+:' | tr -d ':' | sort -u)
dead=$(comm -23 <(printf '%s\n' "$canon") <(printf '%s\n' "$alltok"))
[ -z "$dead" ] && ok "no dead SCHEMA fields — every canonical field is used by some template" \
  || no "SCHEMA fields used by no template: $(tr '\n' ' ' <<<"$dead")"

echo "== C. single risk vocabulary =="
for f in templates/*.md; do
  chk_scale "$f" && ok "one scale: $f" || no "second scale in $f"
done

echo "== D. doctrine, verbatim =="
for f in templates/*.md; do
  dn=$(grep -cF "$DOC" "$f")
  [[ "$dn" =~ ^[0-9]+$ ]] || dn=0
  [ "$dn" -eq 1 ] && ok "doctrine verbatim once: $f" || no "doctrine missing or duplicated in $f (count $dn)"
done

echo "== E. hygiene =="
abshits=$(git ls-files -z | xargs -0 grep -lF -- "$ABS" 2>/dev/null)
[ -z "$abshits" ] && ok "no absolute machine paths in tracked files" || no "absolute path in: $(tr '\n' ' ' <<<"$abshits")"
credhits=""
for ndl in "$CRED1" "$CRED2" "$CRED3" "$CRED4"; do
  h=$(git ls-files -z | xargs -0 grep -lF -- "$ndl" 2>/dev/null)
  [ -n "$h" ] && credhits="$credhits $h"
done
[ -z "$credhits" ] && ok "no credential-shaped strings in tracked files" || no "credential shape in:$credhits"

echo "== F. README count binding =="
rn=$(grep -oE '\*\*[0-9]+ templates\*\*' README.md 2>/dev/null | head -1 | grep -oE '[0-9]+')
[[ "$rn" =~ ^[0-9]+$ ]] || rn=-1
[ "$rn" -eq "$tcount" ] && ok "README template count ($rn) matches the tree ($tcount)" \
  || no "README says $rn templates, the tree has $tcount"

echo "== G. negative controls (the checks must be seen to fire) =="
# Existence first: an expect-fail check against a MISSING fixture passes vacuously — this build
# watched exactly that happen on its first run, caught only by the isolation row. Never again.
for fx in tests/fixtures/bad-undefined-field.md tests/fixtures/bad-second-scale.md; do
  [ -f "$fx" ] && ok "fixture exists: $fx" || no "fixture MISSING (controls would be vacuous): $fx"
done
chk_fields tests/fixtures/bad-undefined-field.md \
  && no "control DID NOT fire: undefined field accepted" || ok "control fires: undefined field caught"
chk_scale tests/fixtures/bad-second-scale.md \
  && no "control DID NOT fire: second scale accepted" || ok "control fires: second scale caught"
chk_structure tests/fixtures/does-not-exist.md \
  && no "control DID NOT fire: phantom file passed structure" || ok "control fires: phantom path refused"
chk_structure tests/fixtures/bad-undefined-field.md && chk_scale tests/fixtures/bad-undefined-field.md \
  && ok "isolation: fixture 1 fails ONLY its target check" || no "fixture 1 leaks into other checks"
chk_structure tests/fixtures/bad-second-scale.md && chk_fields tests/fixtures/bad-second-scale.md \
  && ok "isolation: fixture 2 fails ONLY its target check" || no "fixture 2 leaks into other checks"

echo "== validate-templates: $P PASS / $F FAIL =="
[ "$F" -eq 0 ]
