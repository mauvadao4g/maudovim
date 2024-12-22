#!/bin/bash
# MAUVADAO
# VER: 1.0.1


# FUNÇÃO PRA COLORIR AS MENSAGEM DO ECHO
msg_cor(){
case "$1" in
vm|vermelho)
echo -e "\e[1;31m$2\e[m"
;;
vd|verde)
echo -e "\e[1;32m$2\e[m"
;;
bd|bordo)
echo -e "\e[1;35m$2\e[m"
;;
am|amarelo)
echo -e "\e[1;33m$2\e[m"
;;
cy|cyano)
echo -e "\e[1;36m$2\e[m"
;;
az|azul)
echo -e "\e[1;34m$2\e[m"
;;
*)
echo -e "\e[1;37m$2\e[m"
esac
}


# Obtém a hora atual no fuso horário de São Paulo
hora=$(TZ=America/Sao_Paulo date +%H)
minuto=$(TZ=America/Sao_Paulo date +%M)

# Define as saudações com base no horário
if [ "$hora" -ge 0 -a "$hora" -lt 12 ]; then
    saudacao="Bom Dia"
elif [ "$hora" -ge 12 -a "$hora" -lt 18 ]; then
    saudacao="Boa Tarde"
else
    saudacao="Boa Noite"
fi

# Exibe a saudação e o horário atual
msg_cor 'cyano' "$saudacao. Agora são $hora:$minuto"
