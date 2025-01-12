#!/bin/bash
# MAUVADAO
# VER: 1.0.1
# BASE INSTALL PARA NVIM OU VIM.

function _base() {
curl -sL "https://raw.githubusercontent.com/eduarQuintero73/neovim_configuration/refs/heads/master/init.vim" > $initVim
}

# Configuração do .nvim ou .vimrc
function _configInit() {
cat <<'EOF'	
" Configuração do NVIM 
" Autor: Mauvadao
" Versão: 1.0.1
" Data: 2021-09-30
" ADICIONE SUA CONFIGURAÇÃO NVIM AQUI.
EOF
}


# BAIXANDO DICIONARIO DE LINGUAGENS DO NVIM
#
function _dicionario() {
# 1. Criar o diretório para os dicionáriosAlternativa: Usar github.com
mkdir -p ~/.config/nvim/spell
mkdir -p ~/.vim/spell

# 2. Baixar os arquivos de dicionário
# Portugues.	
curl -so ~/.config/nvim/spell/pt.utf-8.spl https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.spl
curl -so ~/.config/nvim/spell/pt.utf-8.sug https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.sug

# Ingles
curl -so ~/.config/nvim/spell/en.utf-8.spl https://raw.githubusercontent.com/vim/vim/master/runtime/spell/en.utf-8.spl
curl -so ~/.config/nvim/spell/en.utf-8.sug https://raw.githubusercontent.com/vim/vim/master/runtime/spell/en.utf-8.sug

# DAR PERMISSOES AOS ARQUIVOS
chmod 644 ~/.config/nvim/spell/pt.utf-8.spl
chmod 644 ~/.config/nvim/spell/pt.utf-8.sug
chmod 644 ~/.config/nvim/spell/en.utf-8.spl
chmod 644 ~/.config/nvim/spell/en.utf-8.sug

}


# curl -o ~/.config/nvim/spell/pt.utf-8.spl https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.spl &&  curl -o ~/.config/nvim/spell/pt.utf-8.sug https://raw.githubusercontent.com/vim/vim/master/runtime/spell/pt.utf-8.sug

# Alternativa 2: Usar vim.sourceforge.net
function _dicionario2() {
# 1. Criar o diretório para os dicionários
mkdir -p ~/.config/nvim/spell
mkdir -p ~/.vim/spell

# 2. Baixar os arquivos de dicionário
# Portugues.	
curl -so ~/.config/nvim/spell/pt.utf-8.spl https://vim.sourceforge.io/runtime/spell/pt.utf-8.spl
curl -so ~/.config/nvim/spell/pt.utf-8.sug https://vim.sourceforge.io/runtime/spell/pt.utf-8.sug

# Ingles
curl -so ~/.config/nvim/spell/en.utf-8.spl https://vim.sourceforge.io/runtime/spell/en.utf-8.spl
curl -so ~/.config/nvim/spell/en.utf-8.sug https://vim.sourceforge.io/runtime/spell/en.utf-8.sug

# DAR PERMISSOES AOS ARQUIVOS
chmod 644 ~/.config/nvim/spell/pt.utf-8.spl
chmod 644 ~/.config/nvim/spell/pt.utf-8.sug
chmod 644 ~/.config/nvim/spell/en.utf-8.spl
chmod 644 ~/.config/nvim/spell/en.utf-8.sug
}


#   CONFIGURANDO O INIT.VIM
echo -e "\e[1;33mConfigurando o NVIM\e[0m"
initVim="$HOME/.config/nvim/init.vim"
cp $initVim $initVim.bkp
[[ -f $initVim.bkp ]] && { echo "Backup criado com sucesso."; }


# INSTALANDO OS DICIONARIOS
_dicionario


#  ADICONANDO A CONFIGURAÇÃO O EDITOR NVIM
_configInit  > $initVim 
[[ $? == 0 ]] && { echo "Configuração feita com sucesso"; }
nvim +PlugInstall +qall # Instalando os Plugins do Nvim


echo
echo -e "\e[1;33mCONFIGURAÇÃO CONCLUIDA COM SUCESSO\e[0m"
