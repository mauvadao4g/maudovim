#!/bin/bash
clear
snip="$HOME/.vim/plugged/vim-snippets/UltiSnips/sh.snippets"
snipmate="$HOME/.vim/plugged/vim-snippets/snippets/sh.snippets"

# verificar se existe o sh.snippets
[[ ! -f $snip ]] && { echo "UltiSnip: nao encontrado"; }
[[ ! -f $snipmate ]] && { echo "vim-snippets: nao encontrado"; }

status=''
# copiando pra UltiSnips/vim-snippets
cp sh.snippets "$snipmate"
[[ $? == 0 ]] && { status+="Snipmate: \e[1;32mOK\e[0m"'\n'; } || { status+="Snipmate: \e[1;32mNO\e[0m"'\n'; }
# copiando pra vim-snippets
cp sh.snippets "$snip"
[[ $? == 0 ]] && { status+="\e[1;33mSnip: \e[1;32mOK\e[0m"'\n'; } || { status+="Snip: \e[1;31mNO\e[0m"'\n'; }

echo
echo -ne "\e[1;33m"
echo -e  "$status"
# ls  $snip 2>/dev/null
# ls  $snipmate 2>/dev/null
echo -ne "\e[0m"
echo "FIles copiados , teste os snippets com seu vim"

