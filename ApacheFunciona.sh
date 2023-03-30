#!/bin/bash
isActive=$(systemctl is-active httpd.service)
echo "Olá! O servidor estava ">>/efs/OtavioCosta/logs.txt;
if [ $isActive == "active" ];
then
	echo -e "Funcionando!" >> /efs/OtavioCosta/logs.txt
else
	echo -e "Inativo :(">>/efs/OtavioCosta/logs.txt
fi
