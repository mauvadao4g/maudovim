#!/bin/bash
# MAUVADAO
# VER: 1.0.0
#  CONECTAR AO SERVIDOR SSH E FAZER UM GIT PULL  PRA ATUALIZA O REPOSITORIO 

# Dados do servidor
_dadosServer(){
# Definir variáveis
VPS_HOST="$VPS_HOST"
VPS_USER="$VPS_USER"
VPS_PASS="$VPS_PASS"
VPS_PATH="~/maudovim"
PRIVATE_SSH_KEY_PATH="~/.ssh/id_rsa"
}

# Testar conexao com o servidor ssh
_testServer(){
	sshpass -p$VPS_PASS  ssh $VPS_USER@$VPS_HOST -qC 'ls maudovim -d'
}
# Conectar ao servidor e fazer o pull
_conectar(){
# Verificar se o repositório local está atualizado
git pull origin main

# Criar diretório ~/.ssh se não existir
mkdir -p ~/.ssh

# Adicionar a chave privada SSH
# echo "$PRIVATE_SSH_KEY" > $PRIVATE_SSH_KEY_PATH
# chmod 600 $PRIVATE_SSH_KEY_PATH

# Conectar via SSH e fazer a atualização no servidor
sshpass -p$VPS_PASS  ssh -qo StrictHostKeyChecking=no $VPS_USER@$VPS_HOST << EOF
  # Acessa o diretório da aplicação
  cd $VPS_PATH
  
  # Atualiza o repositório no servidor
  git pull origin main
  
EOF

}
_testServer && { echo "Conexao Bem sucedida"; sleep 1;  } && _dadosServer && _conectar
echo "Deploy concluído com sucesso!"
