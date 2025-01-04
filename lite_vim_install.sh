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


Plug 'junegunn/vim-emoji'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
" Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'Shougo/neocomplete.vim'
Plug 'gmarik/Vundle.vim'

" Used to comment whe whole line or select lines
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'


" Plugins de utilidade
Plug 'preservim/nerdtree'       " NERDTree para navegação
Plug 'jiangmiao/auto-pairs'     " AutoPairs para fechamento automático de parênteses
Plug 'vim-syntastic/syntastic' " Syntastic para linting
Plug 'sheerun/vim-polyglot'    " Suporte a múltiplas linguagens
Plug 'dense-analysis/ale'      " Verificação de sintaxe em tempo real

" Plugins para Bash scripting
Plug 'vim-scripts/bash-support.vim'

" Temas
Plug 'dracula/vim', { 'as': 'dracula' }    " tema dracula
Plug 'arcticicestudio/nord-vim'           " tema nord
Plug 'joshdick/onedark.vim'               " tema onedark
Plug 'sainnhe/everforest'                 " tema everforest
Plug 'sainnhe/gruvbox-material'           " tema material basado en gruvbox
Plug 'sainnhe/sonokai'                    " tema sonokai
Plug 'folke/tokyonight.nvim'              " tema tokyo night
Plug 'glepnir/zephyr-nvim'                " tema zephyr
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'tomasr/molokai'

" Mostrar paleta de cores nos codigos Exe; #fff
Plug 'ap/vim-css-color'


call plug#end()

"------------------------------------------------
" Mapeamentos personalizados no modo de inserção
"------------------------------------------------
" Ctrl+e: Vai para o final da linha e continua editando
inoremap <C-e> <Esc>A

" Ctrl+a: Vai para o início da linha e continua editando
inoremap <C-a> <Esc>I

" Ctrl+l: Vai pra linha de baixo
inoremap <C-j> <Esc>o

" Ctrl+k: Vai pra linha de cima
inoremap <C-k> <Esc>k

" Ctrl+L: Apaga a próxima palavra no modo de inserção
inoremap <C-l> <Esc>S





" Define o mapleader
let mapleader=","


" EASY CAPS - Shift + u = upper case, u = lower case
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Save and exit easier way 
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>               " save and exit
nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:exit<cr>               " quit discarding changes
nnoremap <C-q> :exit<cr>


" No more Arrow keys, deal with it
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <S>k <NOP>


inoremap ;; <Esc>
tnoremap ;; <C-\><C-n>

" Opens a new terminal in vertical split
noremap <Leader>t :vsplit term://zsh<CR>


" Mapear <Leader>cc para comentar a linha atual
noremap <Leader>cc <Esc>

" Mapear <Leader><Esc>cc para descomentar a linha atual
inoremap <Leader><Esc>cc <Esc>^x


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
set background=dark
colorscheme sonokai  " Altere para o tema desejado: gruvbox, dracula, etc.


" Configuração do NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1


"------------------------------------------------
" Configuração do emmet
"------------------------------------------------
" Ativar o Emmet apenas em arquivos HTML, CSS, etc.
let g:user_emmet_leader_key='<C-Z>'

" Expandir a abreviação do Emmet com Ctrl+y,
" que é a combinação padrão sugerida pelo plugin
imap <C-y>, <Plug>(emmet-expand-abbr)
nmap <C-y>, <Plug>(emmet-expand-word)

" Navegar entre os pontos de edição do Emmet
imap <C-y>n <Plug>(emmet-next-edit-point)
imap <C-y>p <Plug>(emmet-prev-edit-point)

" Envolver seleção com tag do Emmet (modo visual)
vmap <C-y>, <Plug>(emmet-wrap-with-abbreviation)

"-------------------
" Outras Configurações do Emmet
"-------------------
" Habilitar automaticamente Emmet em tipos de arquivo suportados
autocmd FileType html,css,javascript,php EmmetInstall
let g:user_emmet_settings = {
\   'html' : {
\       'filters' : 'html,css,js',
\   },
\   'css' : {
\       'filters' : 'bem',
\   },
\   'js' : {
\       'filters' : 'js',
\   }
\}

" Personalização de abreviações
" Adicione customizações úteis para projetos recorrentes
let g:user_emmet_custom_snippets = {
\   'html' : {
\       'navheader' : '<nav><ul><li><a href=""></a></li></ul></nav>',
\       'footerlinks' : '<footer><ul><li><a href=""></a></li></ul></footer>',
\   },
\   'css' : {
\       'clearfix' : '&:after { content: ""; display: block; clear: both; }',
\   }
\}

" Auto-expandir "!" para estrutura básica HTML
" "autocmd FileType html inoremap ! html:5<C-y>,


" Outros atalhos úteis
" Mover uma tag ao redor do texto
imap <C-y>d <Plug>(emmet-balance-tag-outward)
imap <C-y>D <Plug>(emmet-balance-tag-inward)

" Incrementar ou decrementar números
imap <C-y>+ <Plug>(emmet-increment-number)
imap <C-y>- <Plug>(emmet-decrement-number)


" ###################
"-------------------
" Configurações de indentação específicas por linguagem
"-------------------
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,css,php setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType sh setlocal tabstop=4 shiftwidth=4 noexpandtab





"-------------------
" Atalhos personalizados
"-------------------
" Alternar entre NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Alternar entre Tagbar
nnoremap <C-b> :TagbarToggle<CR>

" FZF para busca de arquivos
nnoremap <C-p> :Files<CR>

"------------------------------------------------
" Configurações do Airline
"------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula'

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
