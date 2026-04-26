#!/usr/bin/env bash
# setup_vim_bash_ide.sh
set -e

USER_HOME="${HOME:-/root}"
VIMRC="$USER_HOME/.vimrc"

echo "[+] Atualizando pacotes..."
apt update -y

echo "[+] Instalando dependências básicas..."
apt install -y vim git curl build-essential fzf

echo "[+] Instalando Node.js 20 (para coc.nvim)..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

echo "[+] Instalando ferramentas de Bash (lint/format)..."
apt install -y shellcheck shfmt bash-completion

echo "[+] Instalando vim-plug..."
curl -fLo "$USER_HOME/.vim/autoload/plug.vim" --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "[+] Criando ~/.vimrc..."
cat > "$VIMRC" <<'EOF'
" ========= BASICO =========
set nocompatible
set number relativenumber
set cursorline
set tabstop=4 shiftwidth=4 expandtab
set smartindent hidden nowrap
set termguicolors
syntax on
let mapleader=" "

" ========= PLUGINS =========
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" ========= TEMA =========
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

" ========= NERDTREE =========
nmap <C-b> :NERDTreeToggle<CR>

" ========= COC =========
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nmap gd <Plug>(coc-definition)
nnoremap K :call CocActionAsync('doHover')<CR>
nmap <F2> <Plug>(coc-rename)
nmap <leader>f <Plug>(coc-format)
nmap <leader>d :CocDiagnostics<CR>

" ========= ALE (ShellCheck) =========
let g:ale_linters = { 'sh': ['shellcheck'] }
let g:ale_fixers = { 'sh': ['shfmt'] }
let g:ale_fix_on_save = 1

" ========= SALVAR =========
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" ========= EXEC / DEBUG =========
nmap <leader>r :w<CR>:!bash %<CR>
nmap <leader>x :w<CR>:!bash -x %<CR>

" ========= COMENTAR =========
nmap <leader>c gcc

" ========= BUSCA =========
set incsearch ignorecase smartcase hlsearch
EOF

echo "[+] Instalando plugins do Vim..."
vim +'PlugInstall --sync' +qa

echo "[+] Instalando extensão bash (coc-sh)..."
vim +'CocInstall -sync coc-sh' +qa

echo "[+] Verificando versões..."
node -v
vim --version | head -n 1

echo
echo "[✔] Setup concluído."
echo "Abra o Vim e use:"
echo "  Ctrl+b  -> arquivos"
echo "  Space+r -> rodar script"
echo "  Space+x -> debug bash -x"
echo "  gd      -> ir para definição"
echo "  K       -> documentação"
echo "  Ctrl+s  -> salvar"
