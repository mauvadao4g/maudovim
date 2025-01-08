#!/bin/bash

# Função para exibir mensagens coloridas
function print_msg {
    local color=$1
    shift
    case "$color" in
        green) echo -e "\033[0;32m$@\033[0m" ;;
        red) echo -e "\033[0;31m$@\033[0m" ;;
        yellow) echo -e "\033[0;33m$@\033[0m" ;;
        *) echo "$@" ;;
    esac
}

# Clone o repositório do plugin
print_msg yellow "Clonando o repositório bracey.vim..."
git clone https://github.com/turbio/bracey.vim ~/.vim/autoload/plug/start || {
    print_msg red "Erro ao clonar o repositório. Verifique sua conexão e tente novamente."
    exit 1
}

# Identificar o gerenciador de plugins
if [ -d "~/.vim/autoload/plug/start" ]; then
    plugin_dir="~/.vim/autoload/plug/start"
elif [ -d "~/.vim/autoload/plug/start" ]; then
    plugin_dir="~/.vim/autoload/plug/start"\else
    plugin_dir="~/.vim/autoload/plug/start"
fi

print_msg green "Plugin clonado em: $plugin_dir"

# Alterar para o diretório do plugin
cd $plugin_dir || {
    print_msg red "Erro ao acessar o diretório do plugin: $plugin_dir."
    exit 1
}

# Instalar dependências com npm
print_msg yellow "Instalando dependências usando npm..."
npm install --prefix server || {
    print_msg red "Erro ao instalar dependências npm. Certifique-se de que o npm está instalado."
    exit 1
}

# Sugestão para o arquivo .vimrc
print_msg green "Instalação concluída com sucesso!"
print_msg yellow "Para automatizar a instalação das dependências no futuro, adicione a seguinte linha ao seu .vimrc:"
echo "Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}"

exit 0
