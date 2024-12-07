#!/bin/bash
# MAUVADAO
# Script para adicionar, commitar e enviar alterações ao Git
# Versão: 1.0.1

_new() {
    data=$(date '+%Y-%m-%d %H:%M:%S')
    # Obtém o último arquivo correspondente ao padrão "ver[0-9]*"
    file=$(ls ver[0-9]* 2>/dev/null | sort -V | tail -n 1)

    # Se não houver nenhum arquivo correspondente, inicia do zero
    if [[ -z "$file" ]]; then
        num=1
    else
        # Extrai o número da versão do arquivo existente
        num=$(echo "$file" | grep -Eo '[0-9]+')
        # Incrementa o número
        ((num++))
        # Remove o arquivo anterior
        rm "$file"
    fi

    # Cria o novo nome do arquivo
    newFile="ver$num"

    # Cria o novo arquivo
    touch "$newFile"
    # adicionando linha de texto ao novo file
    echo "Ver: $num"
    echo "Update: $data" >> $newFile

    echo "Nova versão atualizada: $newFile"
}

# Chama a função
_new



# Função para exibir mensagens coloridas
msg() {
    local color=$1
    local text=$2
    case "$color" in
        green) tput setaf 2 ;;
        yellow) tput setaf 3 ;;
        red) tput setaf 1 ;;
        *) tput sgr0 ;;
    esac
    echo "$text"
    tput sgr0
}

# Verificação do Git
if ! command -v git &>/dev/null; then
    msg red "Erro: Git não está instalado. Por favor, instale-o antes de usar este script."
    exit 1
fi

# Mensagens de início
msg yellow "Iniciando o script de automação Git..."

# Adicionando alterações
msg green "Adicionando arquivos ao repositório..."
git add -A || { msg red "Erro ao adicionar arquivos."; exit 1; }

# Verificando status
msg green "Verificando o status do repositório..."
git status || { msg red "Erro ao verificar o status."; exit 1; }

# Commit com timestamp
commit_msg="Update: $(date +%d%m%y_%H:%M)"
msg green "Realizando commit com a mensagem: '$commit_msg'"
git commit -m "$commit_msg" || { msg red "Erro ao realizar commit."; exit 1; }

# Enviando alterações
msg green "Enviando alterações para o repositório remoto..."
DIR="$(pwd)"
git config --global --add safe.directory "$DIR" && git push || { msg red "Erro ao enviar alterações."; exit 1; }

# Mensagem de sucesso
msg green "Processo concluído com sucesso!"
