#!/bin/bash

#Cria uma variavel para definir a data do sistema
day=$(date +'%d/%m/%Y')
#Cria uma variavel para definir a hora do sistema
hour=$(date +'%T')
#Cria uma variável para definir se o serviço está ativo ou inativo
isActive=$(systemctl is-active httpd.service)
#Manda a primeira parte do log para o arquivo /efs/OtavioCosta/logs.txt
echo -en "\nOlá! O servidor está">>/efs/OtavioCosta/logs.txt;
#Verifica se o serviço está ativo ou não
if [ $isActive == "active" ];
#Caso esteja, ele adiciona " Funcionando" ao arquivo /efs/OtavioCosta/logs.txt
then
	echo " Funcionando!" >> /efs/OtavioCosta/logs.txt
#Caso não esteja, ele adiciona " Inativo :(" ao arquivo /efs/OtavioCosta/logs.txt
else
	echo " Inativo :(">>/efs/OtavioCosta/logs.txt
fi
#Manda o dia e o horário para o arquivo /efs/OtavioCosta/logs.txt
echo -e "Dia: $day, horário: $hour\n" >> /efs/OtavioCosta/logs.txt
