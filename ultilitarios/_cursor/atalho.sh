#!/bin/bash

# Nome do aplicativo e caminhos
APP_NAME="Cursor"
APP_EXEC="$HOME/Cursor-0.47.9-x86_64.AppImage"  # Altere para o caminho correto do AppImage
ICON_PATH="$HOME/.local/share/icons/cursor.png"  # Altere para o ícone desejado

# Criar ícone padrão (se não existir)
if [ ! -f "$ICON_PATH" ]; then
    echo "Baixando ícone padrão..."
    wget -O "$ICON_PATH" "https://upload.wikimedia.org/wikipedia/commons/5/59/Red_circle.svg"
fi

# Criar atalho na Área de Trabalho
DESKTOP_FILE="$HOME/Área de Trabalho/$APP_NAME.desktop"
if [ ! -d "$HOME/Área de Trabalho" ]; then
    DESKTOP_FILE="$HOME/Desktop/$APP_NAME.desktop"
fi

echo "Criando atalho na área de trabalho..."
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Exec=$APP_EXEC
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Utility;
EOF

chmod +x "$DESKTOP_FILE"

# Criar atalho no Menu de Aplicativos
MENU_FILE="/usr/share/applications/$APP_NAME.desktop"
echo "Criando atalho no menu de aplicativos..."
sudo tee "$MENU_FILE" > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Exec=$APP_EXEC
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Utility;
EOF

sudo chmod +x "$MENU_FILE"

# Criar alias no .bashrc
ALIAS_CMD="alias cursor='$APP_EXEC'"
if ! grep -q "$ALIAS_CMD" ~/.bashrc; then
    echo "Adicionando alias ao ~/.bashrc..."
    echo "$ALIAS_CMD" >> ~/.bashrc
    source ~/.bashrc
fi

echo "Atalhos e alias configurados com sucesso! 🚀"
