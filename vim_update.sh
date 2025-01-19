#!/bin/bash

# Função para verificar a versão do Vim
check_vim_version() {
    echo "Verificando a versão do Vim..."
    local current_version=$(vim --version | head -n 1 | grep -oP '\d+\.\d+\.\d+')
    local required_version="8.1.2269"

    if [[ "$(printf '%s\n' "$required_version" "$current_version" | sort -V | head -n1)" != "$required_version" ]]; then
        echo "A versão atual do Vim ($current_version) é inferior à necessária ($required_version)."
        return 1
    else
        echo "A versão do Vim já está atualizada ($current_version)."
        return 0
    fi
}

# Função para atualizar o Vim no Ubuntu/Debian
update_vim_ubuntu() {
    echo "Atualizando o Vim no Ubuntu/Debian..."
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo apt update
    sudo apt install -y vim
}

# Função para atualizar o Vim no CentOS/RHEL
update_vim_centos() {
    echo "Atualizando o Vim no CentOS/RHEL..."
    sudo yum remove -y vim
    sudo yum install -y epel-release
    sudo yum install -y vim-enhanced
}

# Função para atualizar o Vim no macOS
update_vim_macos() {
    echo "Atualizando o Vim no macOS..."
    brew update
    brew upgrade vim
}

# Função para instalar vim-go
install_vim_go() {
    echo "Instalando o vim-go..."
    mkdir -p ~/.vim/pack/plugins/start
    git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
    vim -c 'GoInstallBinaries' -c 'qa'
    echo "vim-go instalado com sucesso!"
}

# Detectar sistema operacional
detect_os_and_update_vim() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &> /dev/null; then
            update_vim_ubuntu
        elif command -v yum &> /dev/null; then
            update_vim_centos
        else
            echo "Gerenciador de pacotes não suportado."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            update_vim_macos
        else
            echo "Homebrew não encontrado. Instale o Homebrew primeiro."
            exit 1
        fi
    else
        echo "Sistema operacional não suportado."
        exit 1
    fi
}

# Fluxo principal
main() {
    if ! check_vim_version; then
        detect_os_and_update_vim
    fi
    install_vim_go
    echo "Processo concluído!"
}

main
