#!/bin/bash

# Atualiza e instala pacotes essenciais
 apt update &&  apt install -y vim neovim curl git python3-pip nodejs npm

# Configuração do Vim
mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors
curl -LSso ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat > ~/.vimrc <<EOF
call plug#begin('~/.vim/bundle')
Plug 'preservim/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
call plug#end()

" Configurações gerais
syntax on
colorscheme dracula
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set clipboard=unnamedplus
set cursorline
set wrap

" Atalhos básicos
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-a> ggVG
nnoremap <C-x> :wq<CR>
nnoremap <C-e> :qa!<CR>

" Configurações do NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Configurações do Emmet
let g:user_emmet_mode='n'
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall

" Configurações do SuperTab
let g:SuperTabDefaultCompletionType = '<C-n>'

" Configurações do NeoSnippet
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-k> <Plug>(neosnippet_expand)
smap <C-k> <Plug>(neosnippet_expand)

" Configurações do AutoPairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = '<C-p>'

" Configurações do Vim-Commentary
nnoremap <C-c> :Commentary<CR>

" Configurações do Fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gp :Git push<CR>
EOF

# Configuração do Neovim
mkdir -p ~/.config/nvim
cat > ~/.config/nvim/init.vim <<EOF
call plug#begin('~/.local/share/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
call plug#end()

" Configurações gerais
syntax on
colorscheme dracula
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set clipboard=unnamedplus
set cursorline
set wrap

" Atalhos básicos
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-a> ggVG
nnoremap <C-x> :wq<CR>
nnoremap <C-e> :qa!<CR>

" Configurações do NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Configurações do Emmet
let g:user_emmet_mode='n'
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall

" Configurações do SuperTab
let g:SuperTabDefaultCompletionType = '<C-n>'

" Configurações do NeoSnippet
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-k> <Plug>(neosnippet_expand)
smap <C-k> <Plug>(neosnippet_expand)

" Configurações do AutoPairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = '<C-p>'

" Configurações do Vim-Commentary
nnoremap <C-c> :Commentary<CR>

" Configurações do Fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gp :Git push<CR>
EOF

# Instalação dos plugins
vim +PlugInstall +qall
nvim +PlugInstall +qall

# Instalação de bracey (preview em tempo real)
npm install -g bracey

echo "Configuração do Vim e Neovim concluída com sucesso."
