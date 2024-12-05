#!/bin/bash

#  $HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets
snip="$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets"

# verificando existencia do file: sh.snippets
 [[ -f $snip ]] && {
 echo "Subistituindo o file: sh.snippets"
 cp sh.snippets "$snip"
} || {
echo "Nao foi possivel encontrar: sh.snippets"
}
