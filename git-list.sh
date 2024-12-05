#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 <branch_remota>"
  exit 1
fi

BRANCH_REMOTA=$1

echo "Listando arquivos da branch remota: $BRANCH_REMOTA"
git fetch origin "$BRANCH_REMOTA" >/dev/null 2>&1
git ls-tree -r "origin/$BRANCH_REMOTA" --name-only
