#!/bin/bash

instalar_dependencias() {
  # Detectar se o sistema usa apt ou pkg
  if command -v apt > /dev/null 2>&1; then
    GERENCIADOR="apt"
  elif command -v pkg > /dev/null 2>&1; then
    GERENCIADOR="pkg"
  else
    echo "Gerenciador de pacotes não suportado! Apenas apt e pkg são suportados."
    exit 1
  fi

  echo "Usando gerenciador: $GERENCIADOR"
  
  # Atualizar repositórios e pacotes
  echo "Atualizando repositórios e pacotes..."
   $GERENCIADOR update &&  $GERENCIADOR upgrade -y

  # Instalar python3 e pip
  echo "Instalando python3 e pip..."
  if ! command -v python3 > /dev/null 2>&1; then
     $GERENCIADOR install -y python
  fi
  if ! command -v pip > /dev/null 2>&1; then
    python3 -m ensurepip --upgrade ||  $GERENCIADOR install -y python3-pip
  fi

  # Instalar nodejs e npm
  echo "Instalando nodejs e npm..."
  if ! command -v node > /dev/null 2>&1; then
     $GERENCIADOR install -y nodejs
  fi
  if ! command -v npm > /dev/null 2>&1; then
     $GERENCIADOR install -y npm
  fi

  # Atualizar npm
  echo "Atualizando npm..."
   npm install -g npm

  echo "Dependências instaladas com sucesso!"
}

instalar_dependencias