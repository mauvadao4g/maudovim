#!/bin/bash
# MAUVADAO
# VER: 1.0.0

echo "Script escrito com editor vim"


# verifica se a pasta já existe.
PATCH="backup"
[[ -d $PATCH ]] && { echo "$PATCH Já existe"; }  

echo -e "\e[1;34mFinalizando script.\e[0m"
