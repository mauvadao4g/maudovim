#!/bin/bash
# FIX NODE CONFLICT
# MAUVADAO STYLE

set -e

echo "[+] Limpando cache quebrado..."
apt clean
rm -rf /var/cache/apt/archives/*.deb

echo "[+] Corrigindo pacotes quebrados..."
dpkg --configure -a || true
apt --fix-broken install -y || true

echo "[+] Removendo Node antigo (libnode-dev, nodejs)..."
apt purge -y nodejs libnode-dev nodejs-doc || true
apt autoremove -y

echo "[+] Removendo restos manuais..."
rm -rf /usr/include/node
rm -rf /usr/lib/node_modules
rm -rf /usr/bin/node
rm -rf /usr/bin/npm

echo "[+] Atualizando repositórios..."
apt update

echo "[+] Instalando Node 20 (NodeSource)..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

echo "[+] Verificando instalação..."
node -v
npm -v

echo "[+] Instalando Yarn..."
npm install -g yarn

echo "[+] Verificando Yarn..."
yarn -v

echo "[✓] FIX CONCLUIDO"
