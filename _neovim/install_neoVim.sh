#!/bin/bash
# Instalador Neovim (compilação) com verificações
# BY: MAUVADAO

set -e  # para no primeiro erro crítico

LOG="install_nvim.log"

ok()   { echo -e "[OK] $1"; }
erro() { echo -e "[ERRO] $1"; exit 1; }

run(){
    DESC="$1"
    shift
    echo "[+] $DESC..."
    if "$@" >>"$LOG" 2>&1; then
        ok "$DESC"
    else
        erro "$DESC (veja $LOG)"
    fi
}

echo "[+] Iniciando instalação do Neovim..." | tee "$LOG"

# Verifica root
if [[ $EUID -ne 0 ]]; then
    echo -e "\e[1;31mExecute como root (use sudo)\e[0m"
fi

# Verifica internet
ping -c1 github.com &>/dev/null || erro "Sem internet"

# Dependências
run "Atualizando pacotes" apt update
run "Instalando dependências" apt install git ninja-build build-essential cmake gettext curl unzip -y

# Clonar repo
if [[ -d neovim ]]; then
    echo "[!] Diretório neovim já existe, removendo..."
    rm -rf neovim || erro "Falha ao remover diretório antigo"
fi

run "Clonando repositório" git clone https://github.com/neovim/neovim.git

cd neovim || erro "Falha ao entrar no diretório"

# Compilar
run "Compilando Neovim" make CMAKE_BUILD_TYPE=RelWithDebInfo

# Instalar
run "Instalando Neovim" make install

# Verifica instalação
if command -v nvim &>/dev/null; then
    ok "Neovim instalado com sucesso"
    nvim --version | head -n1
else
    erro "Neovim não encontrado após instalação"
fi

echo "[✔] Finalizado"
