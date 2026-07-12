#!/bin/bash
# MAUVADAO
# VER: 1.0.1
# DATA: dom 12 jul 2026 19:29:08 -03


_cp1(){
for dir in */; do
  cp  -v subGit.sh "$dir"
done
}

_cp2(){
find . -maxdepth 1 -type d ! -path . -exec cp -v subGit.sh {} \;
}

_cp3(){
for dir in */; do
  echo -e "\e[1;34m[+] Copiando pra $dir\e[0m"
  cp -v subGit.sh "$dir"
done
}


_cp3
[[ $? == 0 ]] && {
echo -e "\e[1;32mCopiado com sucesso\e[0m"
} || {
echo -e "\e[1;31mErro ao copiar\e[0m"
}
