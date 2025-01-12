#!/bin/bash

echo "Copiando arquivo de configuração do nvim."
echo ...
LOCAL="$(pwd)" # Diretório atual
INIT="$HOME/.config/nvim/init.vim" # Arquivo de configuração do nvim
timestamp=$(date +%Y%m%d%H%M%S) # Timestamp
# Gerando uma cópia do arquivo de configuração do nvim
[[ -f $INIT ]] && cp $INIT $LOCAL/init.vim.$timestamp
[[ $? == 0 ]] && {
  echo "Arquivo de configuração do nvim copiado com sucesso."
  echo "Arquivo de configuração do nvim: $LOCAL/init.vim.$timestamp"
} || {
  echo "Erro ao copiar o arquivo de configuração do nvim."
  exit 1
}





