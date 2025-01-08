#!/bin/bash


cp vimrc $HOME/.vimrc
[[ $? == 0 ]] && echo "Copiado com sucesso" || echo "Erro ao copiar"
