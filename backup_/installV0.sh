#!/bin/bash
# MAUVADAO
# VER: 3.0.2

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
" highlight CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray
highlight CursorLine cterm=bold ctermbg=235 guibg=#1e1e1e

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
inoremap <C-t> <Esc>:vsp term://$SHELL<CR>

" Ctrl+n: Abre o NERDTree
inoremap <C-ç> <Esc>:NERDTreeToggle<CR>
EOF
    

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


}

instalar_dependencias() {
    echo "Instalando dependências..."
    sudo apt update && sudo apt install -y neovim git curl nodejs npm python3 python3-pip
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
    echo "6. Desinstalar  vim+nvim"
    echo "7. Backup HOME/.vimrc"
    echo "0. Sair"
    echo "========================"
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1) instalar_dependencias ;;
        2) configurar_vim_neovim ;;
        3) corrigir_erro_tema ;;
        4) limpar_plugins ;; # Exclui pastas de plugin
        5) backup_configuracoes ;;
        6) _uninstall ;; # Remove os programas e configurações
        7) _bkp ;; # Backup $HOME/.vimrc
        0) echo "Saindo..."; exit 0 ;;
        
        *) echo "Opção inválida!"; menu_principal ;;
    esac

}

# Execução principal
menu_principal

