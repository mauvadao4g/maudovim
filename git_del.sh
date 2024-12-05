#!/bin/bash

# Verificar se os parâmetros foram fornecidos
if [ $# -lt 1 ]; then
  echo "Uso: $0 <branch1> [branch2] [branch3] ..."
  exit 1
fi

# Função para excluir uma branch local
excluir_branch_local() {
  local BRANCH=$1
  if git branch --list "$BRANCH" >/dev/null 2>&1; then
    git branch -d "$BRANCH" 2>/dev/null || git branch -D "$BRANCH"
    echo "Branch local '$BRANCH' excluída."
  else
    echo "Branch local '$BRANCH' não encontrada."
  fi
}

# Função para excluir uma branch remota
excluir_branch_remota() {
  local BRANCH=$1
  if git ls-remote --exit-code --heads origin "$BRANCH" >/dev/null 2>&1; then
    git push origin --delete "$BRANCH"
    echo "Branch remota '$BRANCH' excluída."
  else
    echo "Branch remota '$BRANCH' não encontrada."
  fi
}

# Processar cada branch passada como parâmetro
for BRANCH in "$@"; do
  echo "Processando branch: $BRANCH"
  excluir_branch_local "$BRANCH"
  excluir_branch_remota "$BRANCH"
done
