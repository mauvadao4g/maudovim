#!/bin/bash
# MAUVADAO
# VER: 3.0.0

clear
# Script de configuração avançada do Vim/Neovim com plugins, temas e layouts personalizados

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
    cat > ~/.vimrc << EOF
" Gerenciador de plugins
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
Plug 'Shougo/vimshell.vim'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'Shougo/neocomplete.vim'
Plug 'gmarik/Vundle.vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Configurações do Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula'

" Configurações gerais
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

" Melhor visualização
set cursorline
set termguicolors
highlight CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray

" Configurações do Coc
set hidden
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

" Configuração do auto-pairs
let g:AutoPairsMapBS = 1  " Habilitar backspace para apagar pares automaticamente
let g:AutoPairsFlyMode = 1  " Adicionar fechamento automático durante digitação rápida

" Mapeamentos personalizados no modo de inserção
" Ctrl+e: Vai para o final da linha e continua editando
inoremap <C-e> <Esc>A

" Ctrl+a: Vai para o início da linha e continua editando
inoremap <C-a> <Esc>I

" Ctrl+l: Vai pra linha de baixo
inoremap <C-j> <Esc>j

" Ctrl+k: Vai pra linha de cima
inoremap <C-k> <Esc>k

" Ctrl+t: Abre o terminal na vertical
inoremap <C-t> <Esc>:vsp term://$SHELL<CR>

" Ctrl+n: Abre o NERDTree
inoremap <C-ç> <Esc>:NERDTreeToggle<CR>
EOF

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


}

instalar_dependencias() {
    echo "Instalando dependências..."
    sudo apt update && sudo apt install -y neovim git curl nodejs npm python3 python3-pip
    pip3 install pynvim
    menu_principal
}

corrigir_erro_tema() {
    autolad="$HOME/.vim/autoload/plug/start"
    plugged="$HOME/.vim/plugged"
    echo "Baixando o repositório vim-airline-themes..."
    git clone https://github.com/dracula/vim.git "$autoload/dracula"
    git clone https://github.com/vim-airline/vim-airline-themes.git "$plugged/vim-airline-themes"
    menu_principal
}

limpar_plugins() {
    echo "Limpando plugins antigos para garantir uma instalação limpa..."
    rm -rf ~/.vim/plugged/*
    rm -rf ~/.local/share/nvim/site/plugged/*
    menu_principal
}

backup_configuracoes() {
    echo "Fazendo backup das configurações antigas..."
    timestamp=$(date +%Y%m%d_%H%M%S)
    mkdir -p ~/.config_backup/vim_$timestamp
    mv ~/.vimrc ~/.config_backup/vim_$timestamp/ 2>/dev/null
    mv ~/.config/nvim/init.vim ~/.config_backup/vim_$timestamp/ 2>/dev/null

    menu_principal

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
    echo "6. Sair"
    echo "========================"
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1) instalar_dependencias ;;
        2) configurar_vim_neovim ;;
        3) corrigir_erro_tema ;;
        4) limpar_plugins ;;
        5) backup_configuracoes ;;
        6) echo "Saindo..."; exit 0 ;;
        *) echo "Opção inválida!"; menu_principal ;;
    esac

}

# Execução principal
menu_principal

