#!/bin/bash

# MAUVADAO
# VER: 1.0.0

echo "Iniciando o script de configuração do Vim e Neovim..."

# Função para instalar pacotes
instalar() {
    sudo apt update && sudo apt install -y "$@"
}

# Função para configuração do Vim
configurar_vim() {
    cat > ~/.vimrc << EOF
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Emmet
Plug 'mattn/emmet-vim'

" Bracey
Plug 'turbio/bracey.vim'

" Auto-pairs
Plug 'jiangmiao/auto-pairs'

" NERDTree
Plug 'preservim/nerdtree'

" Temas
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

call plug#end()

syntax on
colorscheme dracula
EOF
}

# Função para configuração do Neovim
configurar_neovim() {
    mkdir -p ~/.config/nvim
    cat > ~/.config/nvim/init.vim << EOF
set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/site/autoload/plugged')

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Emmet
Plug 'mattn/emmet-vim'

" Bracey
Plug 'turbio/bracey.vim'

" Auto-pairs
Plug 'jiangmiao/auto-pairs'

" NERDTree
Plug 'preservim/nerdtree'

" Temas
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

call plug#end()

syntax on
colorscheme dracula
EOF
}

# Instala vim, neovim e curl se não estiverem instalados
[[ $(dpkg -s vim) ]] || instalar vim
[[ $(dpkg -s neovim) ]] || instalar neovim
[[ $(dpkg -s curl) ]] || instalar curl

# Instalação do gerenciador de plugins Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

configurar_vim
configurar_neovim

echo "Vim e Neovim configurados com sucesso!"
Este script instala e configura o Vim e Neovim auotmaticamente no Ubuntu, adicionando plugins frequentemente usados e temas populares. Ele verifica previamente a instalação, instala se necessário e configura ambos os editores utilizando a ferramenta de gerenciamento de plugins Vim-Plug.
