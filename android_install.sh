#!/bin/bash

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Função para exibir mensagens coloridas
function mensagem() {
  local tipo=$1
  local texto=$2
  if [ "$tipo" == "sucesso" ]; then
    echo -e "${GREEN}[✔] $texto${NC}"
  elif [ "$tipo" == "erro" ]; then
    echo -e "${RED}[✘] $texto${NC}"
  else
    echo -e "[!] $texto"
  fi
}

# Verificar se o Termux é o ambiente atual
if [ "$(uname -o)" != "Android" ]; then
  mensagem "erro" "Este script só pode ser executado no Termux."
  exit 1
fi

# Atualizar os pacotes
mensagem "info" "Atualizando pacotes do Termux..."
pkg update -y && pkg upgrade -y && mensagem "sucesso" "Pacotes atualizados com sucesso."

# Instalar o Vim
mensagem "info" "Instalando o Vim..."
if pkg install vim -y; then
  mensagem "sucesso" "Vim instalado com sucesso."
else
  mensagem "erro" "Erro ao instalar o Vim."
  exit 1
fi

# Criar um arquivo de configuração básico do Vim
mensagem "info" "Criando o arquivo de configuração .vimrc..."
cat > ~/.vimrc <<EOL
syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set background=dark
set ruler
EOL

if [ -f ~/.vimrc ]; then
  mensagem "sucesso" "Arquivo de configuração .vimrc criado com sucesso."
else
  mensagem "erro" "Erro ao criar o arquivo .vimrc."
  exit 1
fi

# Finalização
mensagem "sucesso" "Instalação e configuração do Vim concluídas!"
mensagem "info" "Você pode usar o Vim digitando 'vim' no terminal."
