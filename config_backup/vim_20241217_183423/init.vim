"---------------------------------------------------------------
" INICIANDO CONFIGURAÇÕES
" Ver; 06
" MAUVADAO
"---------------------------------------------------------------
"------------------------------------------------
" Gerenciador de plugins
"------------------------------------------------
call plug#begin('~/.vim/autoload/plug/start')

" Plugins essenciais

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'
Plug 'zenorocha/dracula-theme'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'Shougo/neocomplete.vim'
Plug 'gmarik/Vundle.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Testando novos plugins
" Used to comment whe whole line or select lines
Plug 'preservim/nerdcommenter'

" Viminspector to debug
Plug 'puremourning/vimspector'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Better Syntax Support
Plug 'sheerun/vim-polyglot'

" Git pluggin
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Used to shows icons on screen
Plug 'ryanoasis/vim-devicons'

call plug#end()
"------------------------------------------------
" Configurações do VimShell
"------------------------------------------------
" Define a tecla para abrir o VimShell
" nmap <Leader>t :VimShell<CR>

" Use uma janela horizontal para o VimShell
let g:vimshell_window_type = 'horizontal'


"------------------------------------------------
" Configurações do Airline
"------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula'


"------------------------------------------------
" Configurações gerais
"------------------------------------------------
syntax on
filetype plugin indent on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab

" Tema Dracula
set background=dark
colorscheme dracula

"------------------------------------------------
" Melhor visualização
"------------------------------------------------
set cursorline
set termguicolors
" highlight CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray
highlight CursorLine cterm=bold ctermbg=235 guibg=#1e1e1e

"------------------------------------------------
" Configurações do Coc
"------------------------------------------------
set hidden
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

"------------------------------------------------
" Configuração do auto-pairs
"------------------------------------------------
let g:AutoPairsMapBS = 1  " Habilitar backspace para apagar pares automaticamente
let g:AutoPairsFlyMode = 1  " Adicionar fechamento automático durante digitação rápida


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

" Outros atalhos úteis
" Mover uma tag ao redor do texto
imap <C-y>d <Plug>(emmet-balance-tag-outward)
imap <C-y>D <Plug>(emmet-balance-tag-inward)

" Incrementar ou decrementar números
imap <C-y>+ <Plug>(emmet-increment-number)
imap <C-y>- <Plug>(emmet-decrement-number)


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


" Mapeamentos personalizados

" Ctrl+s para salvar
nnoremap <C-s> :w<CR>
" Ctrl+q para sair sem salvar
nnoremap <C-q> :q!<CR>
" Ctrl+d para salvar e encerrar
nnoremap <C-d> :wq<CR>

" Ctrl+t: Abre o terminal na vertical
" inoremap <C-t> <Esc>:vsp term:///bin/bash<CR>
inoremap <C-t> <Esc>:term<CR>

" Ctrl+n: Abre o NERDTree
inoremap <C-ç> <Esc>:NERDTreeToggle<CR>

"----------------------------------------
" novos mapeamentos testes
"----------------------------------------
" Use alt + hjkl to resize windows
nnoremap <M-j>		:resize -2<CR>
nnoremap <M-k>		:resize +2<CR>
nnoremap <M-h>		:vertical resize -2<CR>
nnoremap <M-l>		:vertical resize +2<CR>

" EASY CAPS - Shift + u = upper case,  u =  lower case
inoremap <c-u> <ESC>viwUi
inoremap <c-u> viwU<Esc>

" Save and exit easier way
inoremap <C-s> <esc>:w<cr>
inoremap <C-d> <esc>:wq!<cr>
inoremap <C-q> <esc>:exit<cr>

inoremap ;; <Esc>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open nerdTree with keyshortcut
let mapleader = ","
nmap <leader>ne :NERDTree<cr>


" TABS
noremap <Tab> :tabnext<CR>
noremap <S-Tab> :tabprevious<CR>
noremap <C-t> :tabnew <bar> :NERDTree<CR>
noremap <C-e> :tabclose<CR>


" No more Arrow Keys, deal hith it
noremap <UP> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <S>k <NOP>


" Mapeia ;; para sair do modo de inserção e ir para o modo normal
inoremap ;; <Esc>

" Mapeia ;; para sair do modo terminal  e ir para o modo normal
tnoremap ;; <C-\><C-n>

" Opens a new terminal in vertical split
noremap <leader>t :vsplit term://zsh<CR>

" Comment lines
noremap <leader>cc

"---------------------------------------------------------------
" ENCERRANDO CONFIGURAÇÕES
"---------------------------------------------------------------