#!/bin/bash
# MAUVADAO
# VER: 1.0.0
# CRAIANDO UM DEPLOY PRO GITHUB
clear
# ADICIONANDO UMA CHAVE PRO GITHUB
_keyGen(){
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
}

echo -e "\e[1;33mConfigurando Deploy\e[0m"
file='deploy.yml'

# criar a pasta pra adicionar o file deploy
mkdir -p '.github/workflows'

# Gerando o file de deploy
cat <<'EOF' >  ".github/workflows/$file "
name: Deploy Django App

on:
  push:
    branches:
      - main  # Altere para o branch de deploy se necessário

jobs:
  deploy:
    name: Deploy to VPS
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Setup SSH Key
      env:
        PRIVATE_SSH_KEY: ${{ secrets.PRIVATE_SSH_KEY }}
      run: |
        # Cria o diretório ~/.ssh se não existir
        mkdir -p ~/.ssh

        # Salva a chave privada em um arquivo
        echo "$PRIVATE_SSH_KEY" > ~/.ssh/id_rsa
        chmod 600 ~/.ssh/id_rsa

        # Inicia o agente SSH e adiciona a chave privada
        ssh-keygen -p -f ~/.ssh/id_rsa
        eval $(ssh-agent -s)
        ssh-add ~/.ssh/id_rsa
    - name: Deploy to VPS
      env:
        VPS_HOST: ${{ secrets.VPS_HOST }}
        VPS_USER: ${{ secrets.VPS_USER }}
        APP_PATH: ${{ secrets.APP_PATH }}
      run: |
        # Conecta via SSH e faz o deploy usando Docker Compose
        ssh -qo StrictHostKeyChecking=no $VPS_USER@$VPS_HOST << EOF
          cd $APP_PATH
          git pull origin main

        EOF

    - name: Cleanup
      run: |
        # Remove a chave privada após o deploy
        rm ~/.ssh/id_rsa

EOF


echo "Script finalizado com sucesso"
