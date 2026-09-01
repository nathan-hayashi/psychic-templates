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
[ "$tcount" -eq 6 ] && ok "exactly 6 templates present" || no "template count $tcount != 6"
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


echo "== A2. the ladder — distinct Fields-block counts bound to the README diagram (TPL-R1) =="
ladc=$(for f in templates/*.md; do
  awk '/^## Fields$/{f=1;next} f&&/^## /{exit} f' "$f" | grep -oE '^[a-z_]+:' | sort -u | grep -c .
done | sort -n | tr '\n' ' ')
ladr=$(awk '/^```mermaid$/{f=1;next} f&&/^```/{exit} f' README.md | grep -oE '[0-9]+ fields' | grep -oE '[0-9]+' | sort -n | tr '\n' ' ')
ladn=$(printf '%s' "$ladr" | wc -w); [[ "$ladn" =~ ^[0-9]+$ ]] || ladn=0
[ "$ladn" -eq "$tcount" ] && ok "diagram names one count per template ($ladn)" \
  || no "diagram count rows $ladn != $tcount templates"
{ [ -n "$ladr" ] && [ "$ladr" = "$ladc" ]; } \
  && ok "ladder bound: README diagram == live distinct counts ($ladc)" \
  || no "ladder DRIFT: README [$ladr] vs live [$ladc]"
lp=$(mktemp); sed 's/17 fields/99 fields/' README.md > "$lp"
ladp=$(awk '/^```mermaid$/{f=1;next} f&&/^```/{exit} f' "$lp" | grep -oE '[0-9]+ fields' | grep -oE '[0-9]+' | sort -n | tr '\n' ' ')
[ "$ladp" != "$ladc" ] && ok "control fires: a drifted diagram number is seen by the comparator" \
  || no "ladder control DID NOT fire"
rm -f "$lp"

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
rvals=$(grep -oE '\*\*[0-9]+ templates\*\*|badge/templates-[0-9]+' README.md 2>/dev/null | grep -oE '[0-9]+' | sort -u)
rvn=$(grep -c . <<<"$rvals"); [[ "$rvn" =~ ^[0-9]+$ ]] || rvn=0
{ [ "$rvn" -eq 1 ] && [ "$rvals" = "$tcount" ]; } \
  && ok "README template count bound every-occurrence incl. the badge ($rvals == tree $tcount)" \
  || no "README template binding broken: distinct values [$(tr '\n' ' ' <<<"$rvals")] vs tree $tcount"
rcp=$(mktemp); cat README.md > "$rcp"; printf '\nbadge/templates-99\n' >> "$rcp"
rv2=$(grep -oE '\*\*[0-9]+ templates\*\*|badge/templates-[0-9]+' "$rcp" | grep -oE '[0-9]+' | sort -u | grep -c .)
[[ "$rv2" =~ ^[0-9]+$ ]] || rv2=0
[ "$rv2" -ge 2 ] && ok "control fires: a conflicting badge count reaches the extractor (badge-unbinds-the-prose hole closed)" \
  || no "every-occurrence control DID NOT fire"
rm -f "$rcp"

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


# S0-RECONCILE — the explainer-epoch discipline, ported from the parent with ONE DECLARED
# VARIANCE: an empty post-epoch set is PASS-with-reason here (this repo gates rarely, so the
# epoch row is often the last row); the parent's stricter FAIL stands over there. Grandfathered
# rows (enumerated in INDEX.md) are events recorded without tokens and owe no explainer.
exepoch=$(grep -m1 '^EXPLAINER-EPOCH: ' docs/explainers/INDEX.md 2>/dev/null | awk '{print $2}')
exgf=$(grep -m1 '^EXPLAINER-GRANDFATHERED: ' docs/explainers/INDEX.md 2>/dev/null | sed 's/^EXPLAINER-GRANDFATHERED: //')
if [ -z "${exepoch:-}" ]; then
  no "explainer epoch line missing from docs/explainers/INDEX.md"
else
  exrows=$(awk -F'|' -v ep="$exepoch" '/^\| [A-Za-z]/ { g=$2; gsub(/^ +| +$/,"",g); if (found && g!="Gate") print g; if (g==ep) found=1 }' GATES.md)
  exmiss=""
  for g in $exrows; do
    case " ${exgf:-} " in *" $g "*) continue ;; esac
    [ -f "docs/explainers/$g.md" ] || exmiss="$exmiss [$g]"
  done
  if [ -z "$exrows" ]; then
    ok "explainer epoch: post-epoch set empty (epoch is the last row) — PASS with stated reason (declared variance)"
  elif [ -z "$exmiss" ]; then
    ok "every post-epoch gate has its plain-language explainer"
  else
    no "explainer(s) MISSING for post-epoch gate(s):$exmiss"
  fi
  exfx=$(mktemp); cat GATES.md > "$exfx"
  printf '| PROBE-X9 |  | p | p | awaiting probe |\n' >> "$exfx"
  exrows2=$(awk -F'|' -v ep="$exepoch" '/^\| [A-Za-z]/ { g=$2; gsub(/^ +| +$/,"",g); if (found && g!="Gate") print g; if (g==ep) found=1 }' "$exfx")
  case "$exrows2" in
    *"PROBE-X9"*) ok "explainer fire-probe: a planted post-epoch gate row is seen by the extractor" ;;
    *) no "explainer fire-probe FAILED — a planted row went unseen; the binding is void" ;;
  esac
  rm -f "$exfx"
fi

echo "== validate-templates: $P PASS / $F FAIL =="
[ "$F" -eq 0 ]
