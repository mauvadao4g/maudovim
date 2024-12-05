#!/bin/bash
clear

echo "Copiando Snepptes"

# copiando pra pasta 1
cp sh.snippets ~/.config/nvim/UltiSnips

# copiando pra pasta 2
cp sh.snippets  ~/.vim/UltiSnips

# verificando se o file  está na pasta
[[ -f ~/.vim/UltiSnips/sh.snippets ]] && {
echo "Pasta:  ~/.vim/UltiSnips -> $( ls ~/.vim/UltiSnips)"
}

# verificando se o file está na pasta
[[ -f ~/.config/nvim/UltiSnips/sh.snippets ]] && {
echo "Pasta: ~/.config/nvim/UltiSnips -> $( ls ~/.config/nvim/UltiSnips) "
}

