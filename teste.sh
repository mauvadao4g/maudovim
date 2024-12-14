#!/bin/bash
# MAUVADAO
# VER: 1.0.0


        echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"
        echo -e "\e[1;34mVerificando conexao com o git hub\e[0m"
        echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"

        # Verificando se o git está instalado.
        if ! command -v git &> /dev/null; then
            log "Erro: git não está instalado."
            exit 1
        fi


        # Verificando conexao com o git hub
        function verificar_ssh_github() {
            echo "Verificando conexão SSH com o GitHub..."
            if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
                echo -e "\033[32mConexão SSH com o GitHub está funcionando corretamente!\033[0m"
            else
                echo -e "\033[31mFalha na conexão SSH com o GitHub. Verifique sua chave SSH e tente novamente.\033[0m"
            fi
        }
        
        verificar_ssh_github
