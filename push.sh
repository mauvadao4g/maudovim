#!/bin/bash

# Nome do arquivo de script: script.sh

# Verifica se o diretório atual é um repositório Git
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Erro: Este diretório não é um repositório Git."
  exit 1
fi

# Adiciona todos os arquivos modificados e novos ao staging area
git add .

# Solicita uma mensagem de commit ao usuário
echo "Digite a mensagem do commit:"
read commit_message

# Verifica se a mensagem do commit foi fornecida
if [ -z "$commit_message" ]; then
  echo "Erro: A mensagem do commit não pode ser vazia."
  exit 1
fi

# Faz o commit com a mensagem fornecida
git commit -m "$commit_message"

# Faz o push para o repositório remoto
git push origin main

# Verifica se o push foi bem-sucedido
if [ $? -eq 0 ]; then
  echo "Push realizado com sucesso!"
else
  echo "Erro: Falha ao fazer push."
  exit 1
fi
