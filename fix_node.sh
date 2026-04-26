#!/bin/bash
# MAUVADAO
# FIX_NODE.SH
# Corrige erro dpkg + reinstala Node.js limpo

set -e

echo "[+] Iniciando correção do ambiente Node..."

# ===== CORES =====
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

# ===== CHECK ROOT =====
if [[ $EUID -ne 0 ]]; then
  echo -e "${RED}[-] Execute como root${NC}"
  exit 1
fi

# ===== INFO SISTEMA =====
echo -e "${YELLOW}[!] Status do sistema:${NC}"
free -h
df -h /

# ===== LIMPA CACHE QUEBRADO =====
echo -e "${YELLOW}[+] Limpando cache do APT...${NC}"
apt clean
rm -rf /var/cache/apt/archives/*
rm -rf /var/lib/apt/lists/*

# ===== CORRIGE PACOTES =====
echo -e "${YELLOW}[+] Corrigindo dpkg...${NC}"
dpkg --configure -a || true
apt --fix-broken install -y || true

# ===== REMOVE NODE ANTIGO =====
echo -e "${YELLOW}[+] Removendo Node antigo...${NC}"
apt remove --purge nodejs npm -y || true
rm -rf /usr/lib/node_modules
rm -rf ~/.npm

# ===== ATUALIZA REPOS =====
echo -e "${YELLOW}[+] Atualizando repositórios...${NC}"
apt update -y

# ===== INSTALA DEPENDÊNCIAS =====
echo -e "${YELLOW}[+] Instalando dependências...${NC}"
apt install -y curl ca-certificates gnupg build-essential

# ===== INSTALA NODE 20 =====
echo -e "${YELLOW}[+] Instalando Node.js 20...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

# ===== TESTES =====
echo -e "${YELLOW}[+] Verificando instalação...${NC}"
node -v || echo -e "${RED}[-] Node falhou${NC}"
npm -v || echo -e "${RED}[-] NPM falhou${NC}"

# ===== OPCIONAL: YARN =====
echo -e "${YELLOW}[+] Instalando Yarn...${NC}"
npm install -g yarn

# ===== LIMPEZA FINAL =====
echo -e "${YELLOW}[+] Limpando sistema...${NC}"
apt autoremove -y
apt autoclean

# ===== FINAL =====
echo -e "${GREEN}[✔] Node corrigido e atualizado com sucesso!${NC}"
echo -e "${GREEN}[✔] Versões:${NC}"
node -v
npm -v
yarn -v
