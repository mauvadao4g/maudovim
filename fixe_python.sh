#!/bin/bash

# Verifica permissões
if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa ser executado como root. Use sudo."
#  exit 1
fi

echo "Atualizando pacotes..."
sudo apt update -y


_node(){
pkg install nodejs -y
pkg install npm -y
}

_python(){
# Instala Python 3.12 e pacotes de desenvolvimento
echo "Instalando Python 3.12 e pacotes de desenvolvimento..."
 apt install -y python python3.12 python3.12-dev python3-dev
}

_vimConfig(){
# Configura o Python no Vim/Neovim
echo "Configurando Python no Vim/Neovim..."
if [[ -f ~/.vimrc ]]; then
  echo "let g:python3_host_prog = '$PYTHON_PATH'" >> ~/.vimrc
  echo "Configuração adicionada ao ~/.vimrc"
fi

if [[ -f ~/.config/nvim/init.vim || -d ~/.config/nvim ]]; then
  mkdir -p ~/.config/nvim
  echo "let g:python3_host_prog = '$PYTHON_PATH'" >> ~/.config/nvim/init.vim
  echo "Configuração adicionada ao ~/.config/nvim/init.vim"
fi

# Reinstala o plugin UltiSnips (exemplo com vim-plug)
if [[ -f ~/.vim/autoload/plug.vim || -f ~/.config/nvim/autoload/plug.vim ]]; then
  echo "Atualizando plugins com vim-plug..."
  vim +PlugUpdate +qall
fi

# Recompila Vim/Neovim se necessário
echo "Reinstalando Vim/Neovim com suporte ao Python..."
sudo apt install -y vim-gtk3 neovim python3-neovim
}


_suportePython(){
# Testa o suporte ao Python
echo "Testando suporte ao Python no Vim/Neovim..."
SUPPORT=$(vim --cmd 'echo has("python3")' --cmd 'q')
if [[ "$SUPPORT" -eq 1 ]]; then
  echo "Suporte ao Python habilitado no Vim."
else
  echo "Erro: Suporte ao Python no Vim ainda não está habilitado."
fi

SUPPORT_N=$(nvim --cmd 'echo has("python3")' --cmd 'q' 2>/dev/null)
if [[ "$SUPPORT_N" -eq 1 ]]; then
  echo "Suporte ao Python habilitado no Neovim."
else
  echo "Erro: Suporte ao Python no Neovim ainda não está habilitado."
fi
}


# Verifica o caminho do Python 3
PYTHON_PATH=$(which python3)
if [[ -z "$PYTHON_PATH" ]]; then
  echo "Erro: Python 3 não encontrado. Instale manualmente e execute o script novamente."
  exit 1
fi
echo "Python 3 encontrado em: $PYTHON_PATH"



_node
_python
_vimConfig
_suportePython



echo "Processo concluído!"
