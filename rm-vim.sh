#!/bin/bash

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


_uninstall
