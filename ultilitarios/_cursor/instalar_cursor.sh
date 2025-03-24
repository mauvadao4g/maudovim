#!/bin/bash

SITE: https://www.cursor.com/
# Nome do arquivo AppImage
APPIMAGE="Cursor-0.47.9-x86_64.AppImage"
DOWNLOAD_URL="https://github.com/getcursor/cursor/releases/download/v0.47.9/$APPIMAGE"
INSTALL_DIR="$HOME/.local/bin"

# Verifica se o wget está instalado, se não, instala
if ! command -v wget &> /dev/null; then
    echo "wget não encontrado! Instalando..."
    sudo apt update && sudo apt install -y wget
fi

# Cria o diretório de instalação se não existir
mkdir -p "$INSTALL_DIR"

# Baixa o AppImage
echo "Baixando $APPIMAGE..."
wget -O "$INSTALL_DIR/cursor" "$DOWNLOAD_URL"

# Concede permissão de execução
chmod +x "$INSTALL_DIR/cursor"

# Verifica se foi instalado corretamente
if [[ -f "$INSTALL_DIR/cursor" ]]; then
    echo "Cursor instalado com sucesso! Execute com: cursor"
	echo "Se der Erro: cursor --no-sandbox" 
else
    echo "Erro ao instalar o Cursor!"
    exit 1
fi
