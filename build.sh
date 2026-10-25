#!/bin/sh
# Regenerate hosts from domains.txt. Run after editing domains.txt.
set -eu
cd "$(dirname "$0")"

domains=$(grep -Ev '^\s*(#|$)' domains.txt | awk '{print $1}' | sort -u)
[ -n "$domains" ] || { echo "no domains in domains.txt" >&2; exit 1; }

{
  echo "# Ad & tracker blocklist — hosts format"
  echo "# Generated from domains.txt. Do not edit by hand."
  echo "# Updated: $(date -u +%Y-%m-%d)"
  echo
  printf '%s\n' "$domains" | sed 's/^/0.0.0.0 /'
} > hosts

# self-check: every domain got a line
count=$(printf '%s\n' "$domains" | wc -l)
lines=$(grep -c '^0\.0\.0\.0 ' hosts)
[ "$count" -eq "$lines" ] || { echo "mismatch: $count domains, $lines lines" >&2; exit 1; }
echo "hosts: $lines entries"
