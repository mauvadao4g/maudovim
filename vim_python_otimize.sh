#!/bin/bash
# === SETUP VIM ESTILO VSCode PARA BASH ===
# Emily + Mauvadao 👊🐚

set -euo pipefail

# --- Atualiza pacotes e instala dependências ---
sudo apt update -y
sudo apt install -y vim curl git npm unzip

# Install bash-language-server
# sudo apt install -y bash-language-server
# Instala bash-language-server globalmente via npm
 sudo npm install -g bash-language-server

# Alternativa via snap
# sudo snap install bash-language-server --classic

# --- Instala vim-plug ---
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "[*] Instalando vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# --- Cria ou substitui .vimrc ---
cat > ~/.vimrc << 'EOF'
" ================== Vim VSCode Style para Bash ==================
call plug#begin('~/.vim/plugged')

" Plugins essenciais
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ================== Aparência ==================
syntax on
set background=dark
colorscheme dracula
set number relativenumber
set termguicolors
set cursorline
set showmatch
set laststatus=2

" ================== Editor ==================
set tabstop=4 shiftwidth=4 expandtab autoindent smartindent
set clipboard=unnamedplus
set nowrap
set mouse=a
set noswapfile
set updatetime=300
set signcolumn=yes

" ================== NERDTree ==================
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" ================== Airline ==================
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled=1

" ================== Atalhos ==================
inoremap <C-s> <Esc>:w<CR>a
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q!<CR>
inoremap <C-q> <Esc>:q!<CR>
nnoremap <C-d> :wq!<CR>
inoremap <C-d> <Esc>:wq!<CR>

" Navegação entre splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Comentário rápido
nmap <leader>c gcc
vmap <leader>c gc

" ================== Coc.nvim ==================
" Ativar autocompletar Ctrl+Space
inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Mostrar documentação da palavra sob o cursor
nnoremap K :call CocActionAsync('doHover')<CR>

" Configurações Coc
let g:coc_global_extensions = ['coc-sh', 'coc-snippets']

" ================== ALE (linting) ==================
let g:ale_linters = {'sh': ['shellcheck']}
let g:ale_fixers = {'sh': ['shfmt']}
let g:ale_fix_on_save = 1

" ================== Ctrl+J dentro de aspas ==================
inoremap <expr> <C-j> getline('.')[col('.')-2] =~# "[\"']" ? "\<CR>" : "\<C-j>"

" ================== Remover setas ==================
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" ================== Bash Snippets ==================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ================== Indentação ==================
autocmd FileType sh setlocal tabstop=4 shiftwidth=4 noexpandtab

" ==================================================
EOF

# --- Instala a fonte FiraCode Nerd Font ---
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR"

if [ ! -f "FiraCodeNerdFont-Regular.ttf" ]; then
    echo "[*] Instalando FiraCode NerdFont..."
    curl -fLo FiraCodeNerdFont.zip \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
    unzip -o FiraCodeNerdFont.zip -d .
    fc-cache -fv
    rm FiraCodeNerdFont.zip
fi

# --- Instala plugins do Vim ---
vim +PlugInstall +qall

echo "[✅] Vim VSCode Bash configurado com sucesso!"
