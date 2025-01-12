#!/usr/bin/env bash


echo 'Estamos testando um script'
echo 'Nada de mais , apenas pra fins educativos.'
echo ...
echo 'Vamos ver se você é o usuario root.'
echo
if [ $UID -ne 0  ]; then
	echo 'Você não é o usuario root.'
else
	echo 'você é o usuario root.'
fi

