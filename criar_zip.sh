#!/bin/bash
# MAUDAVPN
# VER 1.0.1
#
clear

# Nome base do arquivo zip
BASE_NAME="$(basename $(pwd))"

# Obtém a data e hora atual no formato desejado
DATE=$(date +"%Y%m%d%H%M%S")

# Nome completo do arquivo zip com data e hora
ZIP_FILE="${BASE_NAME}_${DATE}.zip"

# Comando para criar o arquivo zip ignorando a pasta .git e arquivos MAUVADAO_GIT_HUB*.zip
zip -r "$ZIP_FILE" * -x "*.git/*" "${BASE_NAME}_*.zip" #> /dev/null 2>&1

# Verifica se o arquivo zip foi criado corretamente
if [ $? -eq 0 ] && [ -f "$ZIP_FILE" ]; then
    # Calcula o tamanho do arquivo em MB
    FILE_SIZE=$(du -h "$ZIP_FILE" | awk '{print $1}')
    
    # Mensagem de sucesso com nome e tamanho do arquivo
    echo "Concluído com sucesso"
    echo "$ZIP_FILE $FILE_SIZE"
else
    # Mensagem de erro
    echo "Encontrado erros no arquivo .zip"
fi
