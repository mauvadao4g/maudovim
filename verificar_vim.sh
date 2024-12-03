#!/bin/bash

# Função para verificar suporte ao Python3 no Vim
verificar_vim_python() {
    echo "Verificando suporte ao Python3 no Vim..."
    if vim --version | grep -q "+python3"; then
        echo "O Vim já suporta Python3."
    else
        echo "O Vim não suporta Python3. Instalando uma versão compatível..."
        instalar_vim_python
    fi
}

# Função para instalar o Vim com suporte ao Python3
instalar_vim_python() {
    if command -v pkg &>/dev/null; then
        # Termux
        echo "Detectado Termux. Instalando vim-python..."
        pkg install -y vim-python
    elif command -v apt &>/dev/null; then
        # Debian/Ubuntu
        echo "Detectado Debian/Ubuntu. Instalando vim-gtk3..."
        sudo apt update
        sudo apt install -y vim-gtk3
    elif command -v dnf &>/dev/null; then
        # Fedora
        echo "Detectado Fedora. Instalando vim..."
        sudo dnf install -y vim
    elif command -v pacman &>/dev/null; then
        # Arch Linux
        echo "Detectado Arch Linux. Instalando vim..."
        sudo pacman -Syu --noconfirm vim
    else
        echo "Gerenciador de pacotes não detectado. Por favor, instale o Vim manualmente."
        exit 1
    fi

    # Verificar se a instalação foi bem-sucedida
    if vim --version | grep -q "+python3"; then
        echo "O Vim com suporte ao Python3 foi instalado com sucesso!"
    else
        echo "Falha ao instalar o Vim com suporte ao Python3."
        exit 1
    fi
}

# Executar a verificação
verificar_vim_python
