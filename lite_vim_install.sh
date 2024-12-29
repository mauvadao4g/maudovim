#!/bin/bash

# Verifica se o Vim está instalado
if ! command -v vim &> /dev/null; then
    echo "Vim não está instalado. Instalando agora..."
    sudo apt update && sudo apt install vim -y
fi

# Instala o gerenciador de plugins vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Instalando o gerenciador de plugins vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Cria ou substitui o arquivo .vimrc
cat > ~/.vimrc << 'EOF'
" Plugins com vim-plug
call plug#begin('~/.vim/plugged')

" Plugins de utilidade
Plug 'preservim/nerdtree'       " NERDTree para navegação
Plug 'jiangmiao/auto-pairs'     " AutoPairs para fechamento automático de parênteses
Plug 'vim-syntastic/syntastic' " Syntastic para linting
Plug 'sheerun/vim-polyglot'    " Suporte a múltiplas linguagens
Plug 'dense-analysis/ale'      " Verificação de sintaxe em tempo real

" Plugins para Bash scripting
Plug 'vim-scripts/bash-support.vim'

" Temas
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'ayu-theme/ayu-vim'
Plug 'tomasr/molokai'

call plug#end()


" Define o mapleader
let mapleader=","

" Atalhos personalizados
nnoremap <C-s> :w<CR>
nnoremap <C-d> :wq<CR>
nnoremap <q> :q!<CR>

" Ativando o NERDTree com atalhos
nnoremap <leader>n :NERDTreeToggle<CR>

" Configuração básica do Vim
set number           " Ativa a numeração de linhas
set relativenumber   " Ativa numeração relativa
set tabstop=4        " Configura largura do tab
set shiftwidth=4     " Configura indentação
set expandtab        " Usa espaços em vez de tab
set autoindent       " Ativa autoindentação
set clipboard=unnamedplus " Usa clipboard do sistema


" Configuração dos temas
syntax on
colorscheme sonokai  " Altere para o tema desejado: gruvbox, dracula, etc.

" Configuração do NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" Configuração do auto-pairs
let g:AutoPairsShortcutToggle='<leader>p'
EOF

# Instala as fontes
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR"

if [ ! -f "FiraCode-Regular.ttf" ]; then
    echo "Instalando a fonte FiraCode..."
    curl -fLo FiraCode-Regular.ttf \
        https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Regular.ttf
    fc-cache -fv
fi

# Instala os plugins do Vim automaticamente
vim +PlugInstall +qall

echo "Configuração do Vim concluída com sucesso!"
