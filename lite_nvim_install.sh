#!/bin/bash
# MAUVADAO
# VER: 1.0.1
# INSTALAÇÃO PERSONALIZADA DO NVIM, CONFIGURADA POR MAUVADAO
# ADICIONADO COPILOT DO GITUHUB
# ADICIONADO BRACEY PARA LIVE SERVER
# ADICIONADO VIM-CSS-COLOR
# ADICIONADO VIM-COMMENTARY

function _base() {
curl -sL "https://raw.githubusercontent.com/eduarQuintero73/neovim_configuration/refs/heads/master/init.vim" > $initVim
}

# Configuração do .nvim ou .vimrc
function _configInit() {
cat <<'EOF'	
call plug#begin('~/.config/nvim/plugged')  " directorio donde se van a instalar los plugins
" plugins existentes
" COMPILOT -> GITHUB
Plug  'github/copilot.vim'

" Suporte ao live server para HTML/CSS/JS
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Mostrar paleta de cores nos codigos Exe; #fff
Plug 'ap/vim-css-color'

" Used to comment whe whole line or select lines
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdcommenter'            " comentar rapido codigo

Plug 'vim-airline/vim-airline'            " diseño de la barra en la cual se muestran los modos, la linea, etc.
Plug 'vim-airline/vim-airline-themes'     " temas para el vim-airline
Plug 'easymotion/vim-easymotion'          " plugin para mapear caracteres o palabras rapidas en el codigo
Plug 'preservim/nerdtree'                 " gestor de archivos en forma de arbol.
Plug 'christoomey/vim-tmux-navigator'     " poder navegar entre archivos abiertos
Plug 'jiangmiao/auto-pairs'               " autocompletado de llaves, corchetes, etc.
Plug 'neovim/nvim-lspconfig'              " servidores de lenguajes
Plug 'nvim-lua/completion-nvim'           " autocompletado de lenguajes
Plug 'ryanoasis/vim-devicons'             " iconos para los archivos pero requiere nerdfonts

" nuevos temas
Plug 'dracula/vim', { 'as': 'dracula' }   " tema dracula
Plug 'zenorocha/dracula-theme'
Plug 'morhetz/gruvbox'                    " tema
Plug 'sainnhe/gruvbox-material'           " tema material basado en gruvbox
Plug 'arcticicestudio/nord-vim'           " tema nord
Plug 'joshdick/onedark.vim'               " tema onedark
Plug 'sainnhe/everforest'                 " tema everforest
Plug 'folke/tokyonight.nvim'              " tema tokyo night
Plug 'glepnir/zephyr-nvim'                " tema zephyr
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/sonokai'                    " tema sonokai
Plug 'tomasr/molokai'



" plugins adicionales
Plug 'tpope/vim-fugitive'                 " integracion con git
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " mejor resaltado de sintaxis
Plug 'junegunn/fzf.vim'                   " fuzzy finder
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocompletado basado en async
Plug 'tpope/vim-surround'                 " manejar pares de caracteres como paréntesis, comillas, etc.
Plug 'voldikss/vim-translator'            " traductor rapido
Plug 'mbbill/undotree'                    " historial de cambios
Plug 'voldikss/vim-floaterm'              " terminal flotante dentro de vim
Plug 'kyazdani42/nvim-tree.lua'           " alternativa moderna a nerdtree
Plug 'lewis6991/gitsigns.nvim'            " signos para cambios git en las lineas
Plug 'akinsho/bufferline.nvim'            " barra para manejar buffers

" plugins para snippets y emmet
Plug 'SirVer/ultisnips'                   " motor de snippets
Plug 'honza/vim-snippets'                 " coleccion de snippets
Plug 'mattn/emmet-vim'                    " soporte para Emmet

call plug#end()

":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
" CONFIGURAÇÕES BÁSICAS

set number 				"exibe os números de cada linha no lado esquerdo
set relativenumber 			"mostra os números das linhas de forma relativa
set mouse=a 				"permite interação com o mouse
set noshowmode				"não exibe o modo atual ('normal', 'insert', 'visual', etc.)
syntax enable 				"ativa a coloração de sintaxe para alguns tipos de arquivos como HTML, C, C++
set encoding=utf-8 			"define a codificação de arquivos para aceitar caracteres especiais
set sw=4 				"define a indentação para 4 espaços
set nowrap				"o texto não quebra para a próxima linha, continuando na mesma até o fim
set noswapfile				"evita mensagens sobre arquivos de swap ao abrir alguns arquivos
set clipboard+=unnamedplus		"habilita o uso do clipboard do sistema operacional, permitindo copiar e colar entre o sistema e o nvim

"exibe a coluna limite de 120 caracteres
"set colorcolumns=120

"insere espaços em vez de tabs
"set expandtab

"ignora letras maiúsculas em buscas
"set ignorecase

"não ignora maiúsculas em buscas quando há letras maiúsculas na busca
"set smartcase

"corrige palavras usando dicionários em espanhol ou inglês
"set spelllang=en,es

"corrige palavras usando dicionários em português ou inglês
set spelllang=pt,en


"mantém uma margem ao final das linhas ao rolar
"set scrolloff=7


" CONFIGURAÇÃO DO TEMA
set termguicolors 			"ativa cores verdadeiras na terminal
let g:gruvbox_contrast_dark = 'hard'	"configuração do tema Gruvbox
colorscheme gruvbox			"define o tema Gruvbox

" OUTRAS CONFIGURAÇÕES
"evita autocompletar, auto-inserir e auto-selecionar, útil para trabalhar com LSP que já autocompleta automaticamente
set completeopt=menuone,noinsert,noselect


"      SNIPPETS
" Configuración para UltiSnips
let g:UltiSnipsExpandTrigger="<Tab>"       " Expansión de snippets con Tab
let g:UltiSnipsJumpForwardTrigger="<C-j>" " Saltar hacia adelante con Ctrl+j
let g:UltiSnipsJumpBackwardTrigger="<C-k>" " Saltar hacia atrás con Ctrl+k

" Configuración de snippets personalizados
" Crea un directorio para tus snippets locales si aún no existe
if !isdirectory(expand('~/.config/nvim/snippets'))
  call mkdir(expand('~/.config/nvim/snippets'), 'p')
endif
let g:UltiSnipsSnippetDirectories=['~/.config/nvim/snippets', 'UltiSnips']
" =============================================================================
"
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
"####----||------#######


" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>
"####----||------#######


" EASY CAPS - Shift + u = upper case, u = lower case
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>
"####----||------#######


" Save and exit easier way 
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>               " save and exit
nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:exit<cr>               " quit discarding changes
nnoremap <C-q> :exit<cr>
" Volta pro modo normal ao apertar 2x o ; 
inoremap ;; <Esc>


" Open nerdTree with keyshortcut
let mapleader = ","
nmap <leader>ne :NERDTree<cr>
"####----||------#######

" No more Arrow keys, deal with it
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <S>k <NOP>
"####----||------#######


" Opens a new terminal in vertical split
noremap <Leader>t :vsplit term://zsh<CR>
"####----||------#######


" COMENTARIOS COM ATALHOS
" Mapear <Leader>cc para comentar a linha atual
noremap <Leader>cc <Esc>

" Mapear <Leader><Esc>cc para descomentar a linha atual
inoremap <Leader><Esc>cc <Esc>^x
"####----||------#######


" Selecionar todo o texto 
nnoremap <Leader>a ggVG


" TESTES DE ENVELOPAR AS PALAVRAS
" nnoremap <Leader>c viw:s/\%V\(\w\+\)/"\1"/g<CR> "Envelopa uma palavra
" vnoremap <Leader>c "y:s/\%V\%V/\(.\)/g<CR>"     "Envelopa varias palavras no modo visual


"
"------------------------------------------------
" Configuração do auto-pairs
"------------------------------------------------
" let g:AutoPairsShortcutToggle = '<C-p>'
let g:AutoPairsMapBS = 1  " Habilitar backspace para apagar pares automaticamente
let g:AutoPairsFlyMode = 1  " Adicionar fechamento automático durante digitação rápida
"####----||------#######


" Configurações do Vim-Commentary
nnoremap <C-c> :Commentary<CR>
"####----||------#######

" Configurações do Fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gp :Git push<CR>
"---------------------------------------------------
"####----||------#######


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
"####----||------#######

" ###################
"-------------------
" configurações de indentação específicas por linguagem
"-------------------
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,css,php setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType sh setlocal tabstop=4 shiftwidth=4 noexpandtab
"####----||------#######

"-------------------
" configurações do bracey
"-------------------
let g:bracey_auto_start_browser = 1  " Inicia automaticamente o navegador
let g:bracey_browser_command = 'firefox'  " Define o navegador como Firefox
let g:bracey_server_port = 3000  " Define a porta do servidor
let g:bracey_auto_refresh = 1  " Habilita o auto-refresh automático

" Atalhos personalizados para Bracey
" Iniciar o Bracey com Ctrl+b
nnoremap <C-b> :Bracey<CR>
" Atualizar o Bracey manualmente com Ctrl+u
nnoremap <C-u> :BraceyReload<CR>
" Parar o servidor do Bracey com Ctrl+q
nnoremap <C-q> :BraceyStop<CR>

" Auto-inicialização do Bracey ao abrir arquivos HTML/CSS/JS
" autocmd FileType html,css,js silent! :Bracey
"####----||------#######

"------------------------------------------------
" Configurações do Airline
"------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

"------------------------------------------------
" ADICIONANDO ATALHO PRO SCRIPT subGit.sh
nnoremap <leader>sg :!bash /bin/subGit.sh<CR>
"------------------------------------------------
EOF
}


# BAIXANDO DICIONARIO DE LINGUAGENS DO NVIM
#
function _dicionario() {
# 1. Criar o diretório para os dicionáriosAlternativa: Usar github.com
mkdir -p ~/.config/nvim/spell
mkdir -p ~/.vim/spell

# 2. Baixar os arquivos de dicionário
# Portugues.	
curl -so ~/.config/nvim/spell/pt.utf-8.spl https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.spl
curl -so ~/.config/nvim/spell/pt.utf-8.sug https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.sug

# Ingles
curl -so ~/.config/nvim/spell/en.utf-8.spl https://raw.githubusercontent.com/vim/vim/master/runtime/spell/en.utf-8.spl
curl -so ~/.config/nvim/spell/en.utf-8.sug https://raw.githubusercontent.com/vim/vim/master/runtime/spell/en.utf-8.sug

# DAR PERMISSOES AOS ARQUIVOS
chmod 644 ~/.config/nvim/spell/pt.utf-8.spl
chmod 644 ~/.config/nvim/spell/pt.utf-8.sug
chmod 644 ~/.config/nvim/spell/en.utf-8.spl
chmod 644 ~/.config/nvim/spell/en.utf-8.sug

}


# curl -o ~/.config/nvim/spell/pt.utf-8.spl https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.spl &&  curl -o ~/.config/nvim/spell/pt.utf-8.sug https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.sug

# Alternativa 2: Usar vim.sourceforge.net
function _dicionario2() {
# 1. Criar o diretório para os dicionários
mkdir -p ~/.config/nvim/spell
mkdir -p ~/.vim/spell

# 2. Baixar os arquivos de dicionário
# Portugues.	
curl -so ~/.config/nvim/spell/pt.utf-8.spl https://vim.sourceforge.io/runtime/spell/pt.utf-8.spl
curl -so ~/.config/nvim/spell/pt.utf-8.sug https://vim.sourceforge.io/runtime/spell/pt.utf-8.sug

# Ingles
curl -so ~/.config/nvim/spell/en.utf-8.spl https://vim.sourceforge.io/runtime/spell/en.utf-8.spl
curl -so ~/.config/nvim/spell/en.utf-8.sug https://vim.sourceforge.io/runtime/spell/en.utf-8.sug

# DAR PERMISSOES AOS ARQUIVOS
chmod 644 ~/.config/nvim/spell/pt.utf-8.spl
chmod 644 ~/.config/nvim/spell/pt.utf-8.sug
chmod 644 ~/.config/nvim/spell/en.utf-8.spl
chmod 644 ~/.config/nvim/spell/en.utf-8.sug
}


#   CONFIGURANDO O INIT.VIM
echo -e "\e[1;33mConfigurando o NVIM\e[0m"
initVim="$HOME/.config/nvim/init.vim"
cp $initVim $initVim.bkp
[[ -f $initVim.bkp ]] && { echo "Backup criado com sucesso."; }


# INSTALANDO OS DICIONARIOS
_dicionario


#  ADICONANDO A CONFIGURAÇÃO O EDITOR NVIM
_configInit  > $initVim 
[[ $? == 0 ]] && { echo "Configuração feita com sucesso"; }
nvim +PlugInstall +qall # Instalando os Plugins do Nvim


echo
echo -e "\e[1;33mCONFIGURAÇÃO CONCLUIDA COM SUCESSO\e[0m"
