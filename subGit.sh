#!/bin/bash
# MAUVADAO
# Versão: 1.0.6
# Script para adicionar, commitar e enviar alterações ao Git

# Função para verificar conexão SSH com o GitHub
verificar_ssh_github() {
    echo "Verificando conexão SSH com o GitHub..."
    if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        echo -e "\033[32mConexão SSH com o GitHub está funcionando corretamente!\033[0m"
    else
        echo -e "\033[31mFalha na conexão SSH com o GitHub. Verifique sua chave SSH e tente novamente.\033[0m"
        exit 1
    fi
}

# Verifica a conexão SSH antes de continuar
verificar_ssh_github

# Função para criar nova versão
_new() {
    local commit="$1"
    local data=$(date '+%Y-%m-%d %H:%M:%S')
    local file=$(ls ver[0-9]* 2>/dev/null | sort -V | tail -n 1)
    local num

    if [[ -z "$file" ]]; then
        num=1
    else
        num=$(echo "$file" | grep -Eo '[0-9]+')
        ((num++))
        rm -f "$file"
    fi

    local newFile="ver$num"
    {
        echo "=========================="
        echo "$(basename "$(pwd)")"
        echo "Ver: $num"
        echo "Data: $data"
        echo "Update: ${commit:-New Update}"
        echo "=========================="
    } > "$newFile"

    echo "Nova versão atualizada: $newFile"
}

# Chama a função para criar nova versão
commit="$1"
_new "$commit"

# Função para exibir mensagens coloridas
msg() {
    local color="$1"
    local text="$2"
    case "$color" in
        green) tput setaf 2 2>/dev/null ;;
        yellow) tput setaf 3 2>/dev/null ;;
        red) tput setaf 1 2>/dev/null ;;
        *) tput sgr0 2>/dev/null ;;
    esac
    echo "$text"
    tput sgr0 2>/dev/null
}

# Verifica se o Git está instalado
if ! command -v git &>/dev/null; then
    msg red "Erro: Git não está instalado. Por favor, instale-o antes de usar este script."
    exit 1
fi

# Mensagem inicial
msg yellow "Iniciando o script de automação Git..."

# Obtém o conteúdo da última versão criada
texto=$(cat ver[0-9]* 2>/dev/null)

# Adiciona alterações ao Git
msg green "Adicionando arquivos ao repositório..."
git add -A || { msg red "Erro ao adicionar arquivos."; exit 1; }

# Exibe o status do repositório
msg green "Verificando o status do repositório..."
git status || { msg red "Erro ao verificar o status."; exit 1; }

# Realiza commit com mensagem personalizada
commit_msg="$(date +%d%m%y_%H:%M)\n$commit\n\n$texto"
msg green "Realizando commit com a mensagem:"
echo -e "$commit_msg"
git commit -m "$commit_msg" || { msg red "Erro ao realizar commit."; exit 1; }

# Envia alterações para o repositório remoto
msg green "Enviando alterações para o repositório remoto..."
DIR="$(pwd)"
git config --global --add safe.directory "$DIR"
git push || { msg red "Erro ao enviar alterações."; exit 1; }

# Mensagem de sucesso
msg green "Processo concluído com sucesso!"
echo -ne "\e[1;33mCommit:\e[0m "
COMMIT="$(git log --oneline | head -n1)"
echo "$COMMIT"
echo -ne '\e[1;30m'
cat ver[0-9]* 2>/dev/null
echo -ne '\e[0m'