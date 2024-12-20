#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root!"
  #exit 1
fi

# Atualiza o sistema e instala o Vim
echo "Atualizando pacotes e instalando o Vim..."
apt update && apt upgrade -y
apt install -y vim git curl

# Verifica se Vim foi instalado com sucesso
if ! command -v vim &> /dev/null; then
  echo "Erro: Vim não foi instalado corretamente."
  exit 1
fi

# Configuração de plugins
echo "Configurando plugins do Vim..."

# Diretório do Vim
VIM_DIR="$HOME/.vim"
AUTOLOAD_DIR="$VIM_DIR/autoload"
BUNDLE_DIR="$VIM_DIR/bundle"

mkdir -p "$AUTOLOAD_DIR" "$BUNDLE_DIR"

# Instalação do gerenciador de plugins Pathogen
echo "Instalando Pathogen..."
curl -LSso "$AUTOLOAD_DIR/pathogen.vim" https://tpo.pe/pathogen.vim

# Plugins
declare -A PLUGINS
PLUGINS=(
  ["emmet-vim"]="https://github.com/mattn/emmet-vim.git"
  ["vim-bracy"]="https://github.com/yangmillstheory/vim-bracy.git"
  ["vim-snippets"]="https://github.com/honza/vim-snippets.git"
  ["vim-autopairs"]="https://github.com/jiangmiao/auto-pairs.git"
)

# Clona os plugins
for plugin in "${!PLUGINS[@]}"; do
  echo "Instalando plugin: $plugin..."
  git clone "${PLUGINS[$plugin]}" "$BUNDLE_DIR/$plugin"
done

# Configuração do .vimrc
echo "Configurando .vimrc..."
cat > "$HOME/.vimrc" <<EOF
" Ativar Pathogen
execute pathogen#infect()

" Configurações gerais
syntax on
filetype plugin indent on
set number
set tabstop=4
set shiftwidth=4
set expandtab

" Emmet
let g:user_emmet_leader_key='<C-e>'

" AutoPairs
let g:AutoPairsShortcutToggle='<C-p>'

" Snippets
set rtp+=$VIM_DIR/bundle/vim-snippets
EOF

echo "Configuração concluída!"
echo "Execute 'vim' para verificar os plugins instalados."
