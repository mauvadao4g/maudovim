#!/bin/bash
# MAUVADAO
# VER: 1.0.0

echo -e "\e[1;33mEnviando sh.snippet pras configuracoes do vim\e[0m"

snip="$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets"
cp sh.snippets $snip
# Verificar o status do backup
if [ $? -eq 0 ]; then
    echo -e "\e[1;32mEnviado com sucesso\e[0m"
ls $snip
else
    echo -e "\e[1;31mErro ao copiar o sh.snippets\e[0m"
    exit 1
fi
