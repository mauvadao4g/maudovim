#!/bin/bash
# MAUVADAO
# VER: 1.0.0

# Configuração do servidor
declare -A SERVERS
SERVERS["hostinger"]="br1.forvps.xyz:root:22:123123"

# Nome do servidor para envio
SERVER_NAME="hostinger"

# Obter informações do servidor
IFS=":" read -r HOST USER PORT PASSWORD <<< "${SERVERS[$SERVER_NAME]}"

# Enviar o arquivo para o servidor usando scp e sshpass
echo -e "\033[1;33m[INFO] Enviando '$ZIP_FILE' para o servidor '$SERVER_NAME' usando SCP...\033[om"
if sshpass -p "$PASSWORD" scp -P "$PORT" "$ZIP_FILE" "$USER@$HOST:"; then
    colored_message "32" "[SUCESSO] Arquivo '$ZIP_FILE' enviado para '$SERVER_NAME' com sucesso."
else
echo -e  "\e[1;31m[ERRO] Falha ao enviar o arquivo para '$SERVER_NAME'.\e[0m"
    exit 1
fi

