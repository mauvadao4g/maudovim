#!/bin/bash
# MAUVADAO
# VER: 1.0.0

echo -e "\e[1;33m$MENSAGEM\e[0m"


# Verificar o status do backup
if [ $? -eq 0 ]; then
    echo -e "\e[1;32m\e[0m"
else
    echo -e "\e[1;31mError\e[0m"
    exit 1
fi
