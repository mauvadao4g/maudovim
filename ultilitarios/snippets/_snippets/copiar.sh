#!/bin/bash
# MAUVADAO
# VER: 1.0.0
clear


cp html.snippets ~/.vim/UltiSnips/html.snippets
# verifica se o file foi copiado com sucesso
[[ $? == 0 ]] && {
echo "File copiado com sucesso"
} || echo "Algo deu errado ao copiar seu file."
