#!/bin/bash

day=$(date +'%d/%m/%Y')
hour=$(date +'%I:%M:%S')
isActive=$(systemctl is-active httpd.service)
echo -en "\nOlá! O servidor está">>/efs/OtavioCosta/logs.txt;
if [ $isActive == "active" ];
then
	echo " Funcionando!" >> /efs/OtavioCosta/logs.txt
else
	echo " Inativo :(">>/efs/OtavioCosta/logs.txt
fi
echo -e "Dia: $day, horário: $hour\n" >> /efs/OtavioCosta/logs.txt
