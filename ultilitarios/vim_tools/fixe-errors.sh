#!/bin/bash

# Atualização e instalação de dependências
sudo apt update
sudo apt install -y software-properties-common curl git vim neovim npm

# Atualizar o Vim
VIM_VERSION=$(vim --version | grep "VIM - Vi IMproved" | awk '{print $5}')
if dpkg --compare-versions "$VIM_VERSION" lt "9.0.0438"; then
  echo "Atualizando o Vim..."
  sudo apt install -y vim
else
  echo "Vim já está atualizado."
fi

# Atualizar o Neovim
if command -v nvim &> /dev/null; then
  NVIM_VERSION=$(nvim --version | head -n 1 | awk '{print $2}')
  if dpkg --compare-versions "$NVIM_VERSION" lt "0.8.0"; then
    echo "Atualizando o Neovim..."
    sudo apt install -y neovim
  else
    echo "Neovim já está atualizado."
  fi
else
  echo "Neovim não está instalado. Instalando agora..."
  sudo apt install -y neovim
fi

# Atualizar o Node.js
NODE_VERSION=$(node -v 2>/dev/null | sed 's/v//')
if [ -z "$NODE_VERSION" ] || dpkg --compare-versions "$NODE_VERSION" lt "16.18.0"; then
  echo "Atualizando o Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt install -y nodejs
else
  echo "Node.js já está atualizado."
fi

# Reinstalar o coc.nvim
COC_PATH="~/.vim/autoload/plug/start/coc.nvim"
if [ -d "$COC_PATH" ]; then
  echo "Removendo coc.nvim antigo..."
  rm -rf "$COC_PATH"
fi

echo "Clonando o coc.nvim..."
git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1 "$COC_PATH"
cd "$COC_PATH"
npm install

# Adicionar configuração opcional ao vimrc
if ! grep -q "let g:coc_disable_startup_warning" ~/.vimrc; then
  echo "Adicionando configuração para evitar mensagens de aviso no vimrc..."
  echo "let g:coc_disable_startup_warning = 1" >> ~/.vimrc
fi

# Mensagem final
echo "Ambiente corrigido com sucesso! Reinicie o Vim/Neovim para aplicar as mudanças."
