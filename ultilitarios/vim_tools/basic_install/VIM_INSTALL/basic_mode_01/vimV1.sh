#!/bin/bash

# Atualiza pacotes e instala dependências
apt update && apt upgrade -y
apt install -y vim git curl

# Instalação do vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Configuração do .vimrc
cat > "$HOME/.vimrc" <<EOF
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'

Plug 'mattn/emmet-vim'

Plug 'jiangmiao/auto-pairs'
" Plug 'yangmillstheory/vim-bracy'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Configurações gerais
syntax on
filetype plugin indent on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
colorscheme dracula


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


" Save and exit easier way
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>               " save and exit
nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:exit<cr>               " quit discarding changes
nnoremap <C-q> :exit<cr>


" Ctrl+t: Abre o terminal na vertical
inoremap <C-t> <Esc>:vsp term:///bin/bash<CR>


inoremap ;; <Esc>



"___________________________

" CONFIGURACOES DOS PLUGINS
"___________________________

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
" Configurações do Airline
"------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula'

EOF

# Instalar plugins com vim-plug
vim +PlugInstall +qall
