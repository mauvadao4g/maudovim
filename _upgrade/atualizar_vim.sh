#!/bin/bash

# Atualiza a lista de pacotes
echo "Atualizando a lista de pacotes..."
sudo apt update

# Atualiza o Vim para a versão mais recente disponível
echo "Atualizando o Vim..."
sudo apt upgrade -y vim

# Verifica se o Vim foi atualizado corretamente
echo "Verificando a versão do Vim..."
vim_version=$(vim --version | head -n 1)

# Exibe a versão do Vim
echo "A versão do Vim instalada é: $vim_version"

# Mensagem final
echo "O Vim foi atualizado com sucesso!"
