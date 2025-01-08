#!/bin/bash
# MAUVADAO
# VER: 3.0.8

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
"--------------------------------------------------------
             SE CODIGO VIMRC AQUI
"--------------------------------------------------------
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
        0) echo "Saindo..."; exit 0 ;;

        *) echo "Opção inválida!"; menu_principal ;;
    esac

}

# Execução principal
menu_principal
