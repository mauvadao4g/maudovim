#!/bin/bash
echo "Buscando lista de dominios do Ip "
echo "Digite o Ip: "
read ip
echo "Digite o nome do arquivo: "
read arquivo
echo "Digite o nome do arquivo de saida: "
read saida
echo "Buscando lista de dominios do Ip $ip"

for i in $(cat $arquivo); do
host $i $ip | grep "has address" | cut -d " " -f1,4 >> $saida
done

echo "Lista de dominios do Ip $ip salva no arquivo $saida"

	
# Fim do script
# Autor: Eder Queiroz
# 	
# 		
#
