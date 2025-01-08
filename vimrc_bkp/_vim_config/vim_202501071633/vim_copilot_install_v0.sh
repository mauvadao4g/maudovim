#!/bin/bash
# MAUVADAO
# VER: 4.0.0
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
" Ver; 08
" MAUVADAO
" AJUSTANDO O VIM COPILOT
"---------------------------------------------------------------
"------------------------------------------------
" Gerenciador de plugins
"------------------------------------------------
call plug#begin('~/.vim/autoload/plug/start')
" COPILOT -> GITHUB
Plug 'github/copilot.vim' "COPILOT -> GITHUB

" Temas
Plug 'dracula/vim', { 'as': 'dracula' }    " tema dracula
Plug 'sainnhe/edge'                       " tema edge
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
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'puremourning/vimspector'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'sheerun/vim-polyglot'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovim/nvim-lspconfig'    
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

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

call plug#end()

"------------------------------------------------
" Configurações do VimShell
"------------------------------------------------
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
set background=dark
colorscheme dracula

"------------------------------------------------
" Melhor visualização
"------------------------------------------------
set cursorline
set termguicolors
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
let g:AutoPairsMapBS = 1  " Habilitar backpace para apagar pares automaticamente
let g:AutoPairsFlyMode = 1  " Adicionar fechamento automático durante digitação rápida

" Configurações do Vim-Commentary
nnoremap <C-c> :Commentary<CR>

" Configurações do Fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gp :Git push<CR>

"------------------------------------------------
" Configuração do emmet
"------------------------------------------------
let g:user_emmet_leader_key='<C-Z>'
imap <C-y>, <Plug>(emmet-expand-abbr)
nmap <C-y>, <Plug>(emmet-expand-word)
imap <C-y>n <Plug>(emmet-next-edit-point)
imap <C-y>p <Plug>(emmet-prev-edit-point)
vmap <C-y>, <Plug>(emmet-wrap-with-abbreviation)
autocmd FileType html,css,javascript,php EmmetInstall

" Configurações de indentação específicas por linguagem
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,css,php setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType sh setlocal tabstop=4 shiftwidth=4 noexpandtab

"-------------------
" Atalhos personalizados
"-------------------
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-b> :TagbarToggle<CR>
nnoremap <C-p> :Files<CR>

" Configuração do ALE (Linting)
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
let g:bracey_auto_start_browser = 1
let g:bracey_browser_command = 'firefox'
let g:bracey_server_port = 3000
let g:bracey_auto_refresh = 1
nnoremap <C-b> :Bracey<CR>
nnoremap <C-u> :BraceyReload<CR>
nnoremap <C-q> :BraceyStop<CR>
autocmd FileType html,css,js silent! :Bracey

"------------------------------------------------
" Mapeamentos personalizados no modo de inserção
"------------------------------------------------
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I
inoremap <C-j> <Esc>o
inoremap <C-k> <Esc>k
inoremap <C-l> <Esc>S

" Mapeamentos personalizados
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>


"------------------------------------------------
let mapleader = ","
nmap <leader>ne :NERDTree<cr>



"
" Save and exit easier way 
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:wq!<cr>               " save and exit
nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:exit<cr>               " quit discarding changes
nnoremap <C-q> :exit<cr>

inoremap ;; <Esc>
tnoremap ;; <C-\><C-n>


"
" No more Arrow keys, deal with it
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <S>k <NOP>


" Opens a new terminal in vertical split
noremap <Leader>t :vsplit term://zsh<CR>


" Mapear <Leader>cc para comentar a linha atual
noremap <Leader>cc <Esc>

" Mapear <Leader><Esc>cc para descomentar a linha atual
inoremap <Leader><Esc>cc <Esc>^x
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
