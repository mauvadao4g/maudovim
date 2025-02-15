#!/bin/bash

# Nome do arquivo de script: script.sh

# Verifica a conexão SSH com o GitHub
echo "Verificando conexão SSH com o GitHub..."
ssh -T git@github.com

# Verifica se a conexão SSH foi bem-sucedida
if [ $? -eq 1 ]; then
  echo "Conexão SSH com o GitHub está OK."
else
  echo "Erro: Falha na conexão SSH com o GitHub."
  echo "Certifique-se de que:"
  echo "1. Sua chave SSH está configurada corretamente."
  echo "2. A chave SSH está adicionada ao ssh-agent."
  echo "3. A chave SSH está associada à sua conta do GitHub."
  exit 1
fi

# Verifica se o diretório atual é um repositório Git
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Erro: Este diretório não é um repositório Git."
  exit 1
fi

# Adiciona todos os arquivos modificados e novos ao staging area
git add .

# Solicita uma mensagem de commit ao usuário
# echo "Digite a mensagem do commit:"
# read commit_message

timetamp=$(date '+%Y-%m-%d %H:%M:%S')
commit_message="Update:  $timetamp"





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

echo "$commit_message"


else
  echo "Erro: Falha ao fazer push."
  exit 1
fi
