#!/bin/bash
# MAUVADAO
# VER: 1.0.0
# Automatiza o commit e push para o git.
#


# Fazendo push ao git.
git add .
# Verifica se os arquivos foi adiconados corretamente.
[[ $? -ne 0 ]] && { echo "Erro ao adicionar os arquivos." ; exit 1; }
msg="Commit: $(date +%Y-%m-%d_%H:%M:%S)"
message=${1:-$msg}
data=$(date +%Y-%m-%d_%H:%M:%S)

# Fazendo o commit.
git commit -m "$(echo -e "Commit: $message\n  Data: $data")"
# Verifica se o commit foi feito corretamente.
[[ $? -ne 0 ]] && { clear; echo "Erro ao fazer o commit."  ; exit 1; }

# Fazendo o push.
git push
# Verifica se o push foi feito corretamente.
[[ $? -ne 0 ]] && { clear; echo "Erro ao fazer o push." ; exit 1; }

clear
echo "Push feito com sucesso."
[[ -z $1 ]] && echo "$msg" || echo -e "Commit: $message\nData: $data"
# echo "Data do commit: $(date +%Y-%m-%d_%H:%M:%S)"


