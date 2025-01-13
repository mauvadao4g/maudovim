#!/bin/bash
# MAUVADAO
# VER: 4.0.2
# Adicionado o bracey pra live web
# Adicionado novas configurações de atalhos
# Adicionado configuraçõs de plugins

clear
# Script de configuração avançada do Vim/Neovim com plugins, temas e layouts personalizados

_bkp(){
    timestamp=$(date +%Y%m%d%H%M%S)
    mkdir -p vimrc_$timestamp
# Verificando se a pasta existe
[ ! -d vimrc_bkp ] && {
mkdir -p vimrc_bkp ; }

# copiando os arquivos do $HOME/.vimrc
        cp $HOME/.vimrc vimrc_$timestamp/vimrc
# copiando o sh.snippets
    cp /root/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets vimrc_$timestamp/sh.snippets

    # Movendo a pasta pro diretório de backup
    mv vimrc_$timestamp vimrc_bkp
    clear
    echo -e "\e[1;32mCriado com sucesso!\e[0m"
    echo -ne '\e[44;1;37mFile:\e[0m: '
  ls vimrc_bkp/vimrc_$timestamp

}

_uninstall(){
echo "Desinstalando o vim+nvim"
echo

# deletando pastas e arquivos do vim+nvim
rm -rf $HOME/.config/vim >/dev/null 2>&1
rm -rf $HOME/.config/nvim >/dev/null 2>&1
rm -rf $HOME/.vim
rm -f $HOME/.vimrc >/dev/null 2>&1
rm -f $HOME/.init.vim >/dev/null 2>&1

pacote="vim nvim"
# desinstalando o vim+nvim do sistema
# sudo apt remove --purge purple vim && sudo apt autoremove && sudo apt clean
 apt remove --purge purple $pacote
 apt autoremove
 apt clean
echo "Vim removido do sistema"

}

pluginNvim(){
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

pluginVim(){
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

configurar_vim_neovim() {
    echo "Criando diretórios de configuração do Vim e Neovim..."
    mkdir -p ~/.vim/plugged
    mkdir -p ~/.config/nvim

    echo "Baixando o gerenciador de plugins vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


    echo "Configurando o Vim e Neovim..."
    cat > temp.vim << EOF
"---------------------------------------------------------------
" INICIANDO CONFIGURAÇÕES
" Ver: 10
" MAUVADAO
"---------------------------------------------------------------
"------------------------------------------------
" Gerenciador de plugins
" Install VimPlug from - https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"------------------------------------------------

call plug#begin('~/.vim/autoload/plug/start')

" COMPILOT -> GITHUB
Plug  'github/copilot.vim'

" Temas
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
Plug 'zenorocha/dracula-theme'
Plug 'morhetz/gruvbox'
" temas Novos.
Plug 'rakr/vim-one' " For mac
" Plug 'sonph/onehalf', { 'rtp': 'vim' } "preferred on linux server
Plug 'dracula/vim', { 'as': 'dracula' }    " tema dracula

" Suporte ao live server para HTML/CSS/JS
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Mostrar paleta de cores nos codigos Exe; #fff
Plug 'ap/vim-css-color'



Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'Shougo/neocomplete.vim'
Plug 'gmarik/Vundle.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
"------------------------
" TESTANDO NOVOS PLUGINS
"------------------------
" Used to comment whe whole line or select lines
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'


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


" Styled components
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Go extension
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" lsp
Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'


"Git plugin
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Prettier for code
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" Used to shows icons on screen
Plug 'ryanoasis/vim-devicons'

"Plugin for search engine inside nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'


" Viminspector to debug
Plug 'puremourning/vimspector'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'




" Suporte a Python
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'

" Melhor navegação entre arquivos
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Melhor navegação de código
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'

" Suporte para controle de Git
Plug 'tpope/vim-fugitive'

" Plugins adicionais para suporte a PHP
Plug 'StanAngeloff/php.vim'


" Suporte a Python
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'

" Melhor navegação entre arquivos
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
highlight Comment gui=none cterm=none
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
" let g:AutoPairsShortcutToggle = '<C-p>'
let g:AutoPairsMapBS = 1  " Habilitar backspace para apagar pares automaticamente
let g:AutoPairsFlyMode = 1  " Adicionar fechamento automático durante digitação rápida


" Configurações do Vim-Commentary
nnoremap <C-c> :Commentary<CR>

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



"-------------------
" Configuração do ALE (Linting)
"-------------------
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'php': ['phpcs'],
\   'html': ['htmlhint'],
\   'css': ['stylelint'],
\   'sh': ['shellcheck']
\}
let g:ale_fixers = {
\   'python': ['black', 'isort'],
\   'php': ['phpcbf'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'sh': ['shfmt']
\}
let g:ale_fix_on_save = 1


"-------------------
" Configuração do Bracey
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
autocmd FileType html,css,js silent! :Bracey


"####----||------#######

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
" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" EASY CAPS - Shift + u = upper case, u = lower case
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Save and exit easier way
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
" inoremap <C-d> <esc>:wq!<cr>               " save and exit
" nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:exit<cr>               " quit discarding changes
nnoremap <C-q> :exit<cr>


" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" TABS
noremap <Tab> :tabnext<CR>
noremap <S-Tab> :tabprevious<CR>
nnoremap <C-t> :tabnew<CR>
 noremap <C-k> :tabclose<CR>
" noremap <C-e> :tabclose<CR>

" No more Arrow keys, deal with it
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <S>k <NOP>

"----------------------
tnoremap ;; <C-\><C-n>
inoremap ;; <Esc>
"----------------------

" Open nerdTree with keyshortcut
let mapleader = ","
" nmap <leader>g :normal! ggVG<CR> "Seleciona todas as linhas
nmap <leader>ne :NERDTree<cr> "Abre o NerdTree

"-------------------------------
" Configurações do Fugitive
" nnoremap <Leader>gs :Git<CR>
" nnoremap <Leader>gc :Git commit<CR>
" nnoremap <Leader>gp :Git push<CR>
"-------------------------------
" Git fugitive mappings
noremap <leader>gl :G log<CR>
noremap <leader>gc :G commit<CR>
noremap <leader>gp :G push<CR>

" Equivalent to git status
noremap <leader>gs :G <CR>

"open github url on web browser
noremap <leader>gb :GBrowse <CR> 
"-------------------------------

" Mapeamento para abrir o terminal
 noremap <Leader>t :vsplit term://zsh<CR>


" Mapear <Leader>cc para comentar a linha atual
noremap <Leader>cc <Esc>

" Mapear <Leader><Esc>cc para descomentar a linha atual
inoremap <Leader><Esc>cc <Esc>^x

"Search for all ocourrences of the phrase that you write
nnoremap <C-f> :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })<CR>

" CTRL + C now yank the selected
vmap <C-c> "+y

" Clears the vim highlighing
noremap <C-l> :noh<CR>

" Changes all ocourrences for the text that you have typed
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"Debugging keys
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

" Keys for completion
" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')

nmap <Leader>rr :NERDTreeFocus<cr>R<c-w><c-p>


"  PLUGINS SETINGS
" VimSpector
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput
autocmd FileType java nmap <leader>dd :CocCommand java.debug.vimspector.start<CR>



" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gdd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gk <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap <silent> mm <cmd>lua vim.lsp.buf.rename()<CR>
" close rename win use <C-c> in insert mode or  in noremal mode or


"---------------------------------------------------------------
" ADICIONANDO ATALHO PRO SCRIPT subGit.sh
"---------------------------------------------------------------
nnoremap <leader>sg :!bash /bin/subGit.sh<CR>

"---------------------------------------------------------------
" ENCERRANDO CONFIGURAÇÕES
"---------------------------------------------------------------
EOF


	# CONFIGURAÇÕES DE SNIPPETS E ARQUIVOS PRINCIPAIS
    mv temp.vim ~/.vimrc
    cp ~/.vimrc ~/.config/nvim/init.vim

    echo "Instalando plugins do Vim e Neovim..."
    vim +PlugInstall +qall
    nvim +PlugInstall +qall
    # instalando os snippets
    snip="$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets"
     [[ -f "$snip" ]] && {
       # copiando o snippets pras configurações do vim
       cp sh.snippets "$snip"
       [[ $? == 0 ]] && { echo "Snippets configurado com sucesso"; }

     }

	# CONFIGURANDO O CSS SNIPPETS
	htmlsnip="/home/everton-rozendo/.vim/autoload/plug/start/vim-snippets/UltiSnips/html.snippets"
	cp html.snippets "$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/html.snippets"
	[[ -f "$htmlsnip" ]] && {
		# Verificando se foi copiado corretamente.
       [[ $? == 0 ]] && { echo "html.nippets configurado com sucesso"; }
	    }

		#  FIM DAS CONFIGURAÇÕES DE ARQUIVOS E SNIPPETS


}

instalar_dependencias() {
    echo "Instalando dependências..."
     apt update &&  apt install -y neovim git curl nodejs npm python3 python3-pip
    pip3 install pynvim
    verPython
    menu_principal
}

verPython(){
    echo "Verificando suporte ao Python3 no Vim..."
    if vim --version | grep -q "+python3"; then
        echo "O Vim já suporta Python3."

    else
        echo "O Vim não suporta Python3. Instalando uma versão compatível..."

        [ -f verificar_vim.sh ] && {
        bash verificar_vim.sh
        } || {
        echo "verificar_vim.sh: nao encontrado"
        sleep 3
        }
    fi

}

corrigir_erro_tema() {
    autolad="$HOME/.vim/autoload/plug/start"
    plugged="$HOME/.vim/plugged"
    echo "Baixando o repositório vim-airline-themes..."
    git clone https://github.com/dracula/vim.git "$autoload/dracula"
    git clone https://github.com/vim-airline/vim-airline-themes.git "$plugged/vim-airline-themes"
    menu_principal
}


# Configurando o vimShell
vimProc(){
 apt install -y build-essential
# no nvim seria
# cd $HOME/.local/share/nvim/plugged/vimproc.vim
# make

# no vim
cd $HOME/.vim/plugged/vimproc.vim
make
}


limpar_plugins() {
    echo "Limpando plugins antigos para garantir uma instalação limpa..."
    rm -rf ~/.vim/plugged/*
    rm -rf ~/.local/share/nvim/site/plugged/*
    menu_principal
}

backup_configuracoes() {
    echo "Fazendo backup das configurações antigas..."
    # Criando nomes e pastas
    timestamp=$(date +%Y%m%d_%H%M%S)
    pasta="vim_$timestamp"
    mkdir -p "$pasta"

    cp $HOME/.vimrc  $pasta/vimrc 2>/dev/null
    cp $HOME/.config/nvim/init.vim $pasta/init.vim 2>/dev/null

# copiando o sh.snippets
    cp $HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets $pasta/ 2>/dev/null

    zip -r $pasta.zip $pasta
    # Verificar o status do backup
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mCriado: $pasta.zip\e[0m"
        clear
        rm -rf $pasta
        unzip -t $pasta.zip
        mv $pasta.zip vimrc_bkp
    else
        echo -e "\e[1;31mError: $pasta.zip\e[0m"
        exit 1
    fi
echo
echo -e "\e[1;33mFinalizado: $pasta\e[0m"
exit 0
}

menu_principal() {
    clear
    echo "========================"
    echo " Configurador de Vim "
    echo "========================"
    echo "1. Instalar dependências"
    echo "2. Configurar Vim e Neovim"
    echo "3. Corrigir erro do tema Dracula"
    echo "4. Limpar plugins antigos"
    echo "5. Fazer backup das configurações atuais"
    echo "6. Desinstalar  vim+nvim"
    echo "7. Backup HOME/.vimrc"
	echo "v. Lite VIM Install."
	echo "n. Lite NVIM Install."
    echo "0. Sair"
    echo "========================"
    read -p "Escolha uma opção: " opcao

    case $opcao in
        i|-i)
  limpar_plugins
  instalar_dependencias
  configurar_vim_neovim   
  vimProc
  backup_configuracoes
     
        ;;
        1) instalar_dependencias ;;
        2) configurar_vim_neovim; vimProc ;;
        3) corrigir_erro_tema ;;
        4) limpar_plugins ;; # Exclui pastas de plugin
        5) backup_configuracoes ;;
        6) _uninstall ;; # Remove os programas e configurações
        7) _bkp ;; # Backup $HOME/.vimrc
		v) bash lite_vim_install.sh;; # INSTALAÇÃO LITE VIM
		n) bash lite_nvim_install.sh ;; # INSTALAÇÃO LITE NVIM
        0) echo "Saindo..."; exit 0 ;;

        *) echo "Opção inválida!"; menu_principal ;;
    esac

}

# Execução principal
menu_principal
