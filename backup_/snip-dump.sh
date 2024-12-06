#!/bin/bash


    # instalando os snippets
    snip="$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets"
     [[ -f "$snip" ]] && {
       # copiando o snippets pras configurações do vim
       cp sh.snippets "$snip"
       [[ $? == 0 ]] && { echo "Snippets configurado com sucesso"; } || {
       echo -e "\e[1;31m[❌]ERROR AO COPIAR SNIPPETS[❌]" 
       }
 
     }

