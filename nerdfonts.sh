#!/bin/bash


# Verificar se o dbus está instalado no sistema.
if ! command -v dbus-x11 >/dev/null 2>&1
then
sudo apt install dbus-x11
fi

# Nome da Nerd Font que será instalada
FONT_NAME="Hack"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip"
FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR="/tmp/nerdfont_install"

# Função para exibir mensagens coloridas
function mensagem() {
  echo -e "\033[1;32m$1\033[0m"
}

# Verifica o sistema operacional
function verificar_sistema() {
  if [ "$(uname -o)" == "Android" ]; then
    echo "Termux"
  elif [ "$(uname -s)" == "Linux" ]; then
    echo "Linux"
  else
    echo "Sistema não suportado!"
    exit 1
  fi
}




# Baixa e instala a fonte
function instalar_fonte() {
  mensagem "Baixando e instalando a Nerd Font '$FONT_NAME'..."

  mkdir -p "$TEMP_DIR" "$FONT_DIR"
  curl -sL "$FONT_URL" -o "$TEMP_DIR/$FONT_NAME.zip"

  if [ $? -ne 0 ]; then
    echo "Erro ao baixar a fonte!"
    exit 1
  fi

  unzip -o "$TEMP_DIR/$FONT_NAME.zip" -d "$TEMP_DIR"
  mv "$TEMP_DIR"/*.ttf "$FONT_DIR/"

  mensagem "Fonte instalada em $FONT_DIR!"
}

# Atualiza cache de fontes
function atualizar_cache() {
  mensagem "Atualizando cache de fontes..."
  if fc-cache -fv &>/dev/null; then
    mensagem "Cache de fontes atualizado com sucesso!"
  else
    echo "Erro ao atualizar o cache de fontes!"
    exit 1
  fi
}

# Configura a fonte no GNOME Terminal
function configurar_gnome_terminal() {
  mensagem "Configurando GNOME Terminal para usar a Nerd Font..."
  PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
  if [ -z "$PROFILE" ]; then
    echo "Não foi possível encontrar o perfil padrão do GNOME Terminal!"
    exit 1
  fi

  gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/" font "${FONT_NAME} Nerd Font 12"
  mensagem "Fonte configurada automaticamente no GNOME Terminal!"
}

# Define a fonte no Termux
function configurar_termux() {
  mensagem "Configurando Termux para usar a Nerd Font..."
  TERMUX_CONFIG="$HOME/.termux/font.ttf"
  cp "$FONT_DIR/${FONT_NAME} Nerd Font Complete.ttf" "$TERMUX_CONFIG"

  mensagem "Fonte configurada no Termux! Reinicie o aplicativo para aplicar."
}

# Define a fonte no Linux
function configurar_linux() {
  if command -v gsettings &>/dev/null; then
    configurar_gnome_terminal
  else
    mensagem "Por favor, configure manualmente a fonte no terminal (ex.: GNOME Terminal ou Konsole)."
  fi
}

# Limpeza temporária
function limpar() {
  rm -rf "$TEMP_DIR"
}

# Script principal
function main() {
  local sistema=$(verificar_sistema)
  instalar_fonte
  atualizar_cache

  if [ "$sistema" == "Termux" ]; then
    configurar_termux
  else
    configurar_linux
  fi

  limpar
}

main
