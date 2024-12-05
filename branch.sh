#!/bin/bash

# Verificar se os parâmetros foram fornecidos
if [ $# -lt 3 ]; then
  echo "Uso: $0 <arquivo> <branch_origem> <branch_destino>"
  exit 1
fi

# Parâmetros
ARQUIVO=$1
BRANCH_ORIGEM=$2
BRANCH_DESTINO=$3

# Função para exibir mensagens coloridas
mensagem() {
  echo -e "\e[1;32m$1\e[0m"
}

# Garantir que as alterações estão salvas antes de trocar de branch
mensagem "Garantindo que as alterações na branch atual estão salvas..."
git add "$ARQUIVO" 2>/dev/null
git commit -m "Comitando $ARQUIVO na branch $BRANCH_ORIGEM" 2>/dev/null

# Trocar para a branch destino
mensagem "Mudando para a branch $BRANCH_DESTINO..."
git checkout "$BRANCH_DESTINO" || exit 1

# Mesclar o arquivo da branch origem
mensagem "Trazendo o arquivo $ARQUIVO da branch $BRANCH_ORIGEM para $BRANCH_DESTINO..."
git checkout "$BRANCH_ORIGEM" -- "$ARQUIVO" || exit 1

# Commit na branch destino
mensagem "Fazendo commit do arquivo na branch $BRANCH_DESTINO..."
git add "$ARQUIVO"
git commit -m "Adicionando $ARQUIVO da branch $BRANCH_ORIGEM para $BRANCH_DESTINO"

mensagem "Operação concluída com sucesso!"
