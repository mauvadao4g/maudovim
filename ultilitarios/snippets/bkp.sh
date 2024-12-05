#!/bin/bash
# MAUVADAO
# VER: 1.0.0
# DATA; DATA_CRIACAO


snippets="sh.snippets"
destino="$HOME/.vim/pack/vendor/start/vim-snipmate/snippets/sh.snippets"
start="$HOME/.vim/pack/vendor/start"


case $1 in
b|-b)
cp "$destino" sh.snippets_1
cp $HOME/.vim/pack/vendor/start/vim-snippets/snippets/sh.snippets  sh.snippets_2

;;
c|-c)
cp "$snippets" "$destino"
;;

m|-m)
echo "Copiando pra vim-snippets"
cp sh.snippets   $HOME/.vim/pack/vendor/start/vim-snippets/snippets/sh.snippets
;;
*)
echo "Parametros"
cat <<EOF

-b  -> backup sh.snippetts: vim-snipmate
-c  -> Copiar pra pasta vim-snipmate
-m  -> Copiar pra pasta vim-snippets

EOF
esac


if [[ $? == 0 ]]; then 
echo "Executado com sucesso"
else
echo "Algo deu errado ao executar"
 fi
