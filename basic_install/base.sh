#!/bin/bash
# MAUVADAO
# VER: 1.0.4

# CONFIGURAÇÃO AUTOMAIZADA PRO VIM, EDITOR DE TEXTO NO TERMINAL
# PLUGIN BRACEY CONFIGURADO PRA LIVE SERVER DE HTML
# PLUGIN SNIPPETS PRA GERAR SEUS  CODIGOS MAIS RAPIDAMENTE
# CONFIGURAÇÕES UTEIS PRA EDIÇÕES DE CODIGOS DE PROGRAMAÇÃO


# Atualiza pacotes e instala dependências
apt update && apt upgrade -y
apt install -y vim git curl

_bracey(){
git clone https://github.com/turbio/bracey.vim ~/.vim/autoload/plug.vim/bracey.vim

# RODAR
 cd  $HOME/.vim/plugged/bracey.vim/ 
 npm install --prefix server
}


# Instalação do vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Configuração do .vimrc
cat > "$HOME/.vimrc" <<EOF





EOF

# Instalar plugins com vim-plug
vim +PlugInstall +qall
