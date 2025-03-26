#!/bin/bash

# Atualiza a lista de pacotes do sistema
echo "Atualizando a lista de pacotes..."
sudo apt update -y

# Instalar as dependências necessárias para compilar o Vim
echo "Instalando dependências necessárias..."
sudo apt install -y git make ncurses-dev gcc

# Baixando o código-fonte do Vim
echo "Baixando o código-fonte do Vim..."
cd /tmp
git clone https://github.com/vim/vim.git

# Compilando o Vim a partir do código-fonte
echo "Compilando o Vim..."
cd vim
make

# Instalando a versão compilada do Vim
echo "Instalando o Vim compilado..."
sudo make install

# Verificando a versão do Vim instalada
echo "Verificando a versão do Vim..."
vim_version=$(vim --version | head -n 1)
echo "A versão do Vim instalada é: $vim_version"

# Mensagem final
echo "O Vim foi atualizado com sucesso!"
