#!/bin/bash
# MAUVADAO
# VER: 1.0.0


echo -e "\e[1;33mVerificando se o .zip está corrompido ou com problemas.\e[0m"

        read -p "File: " file

        echo -e "\e[1;34mTestando\e[0m"
        echo '...'

        unzip -t "$file"
    echo -e "\e[1;31mVamos fazer uma segunda checagem\e[0m"
        zip -T "$file" 
        echo -e "\e[1;35mChecagem concluida com sucesso\e[0m"

        echo
        echo -e "\e[1;33mVamos verificar com 7z\e[0m"
        echo ...

        7z t "$file"
