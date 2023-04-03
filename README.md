# OtavioEFS
<p align="center">
    <img src="https://www.sophos.com/sites/default/files/2022-02/aws-logo-white-orange.png">
  </p>

## Criando uma instancia com um EFS na aws, configurando apache e fazendo um script que avisa se o servidor está online ou offline. 

### *Primeiro, crie um EFS, para poder configura-lo no user data da instância no momento de sua criação, junto com o apache para facilitar o processo.*

### *Detalhes da Instância:* 
  - **SO: Amazon Linux 2 (Família t3.small)**

  - **Portas Liberadas no SG:**
    * 22/TCP - SSH
    * 111/TCP - Usado para mapear portas RPC não registradas  
    * 111/UDP - Usado para mapear portas RPC não registradas  
    * 2049/TCP - NFS
    * 2049/UDP - NFS
    * 80/TCP - HTTP
    * 443/TCP - HTTPS
  
  - **Volume:**  
    1x16GB gp2

  - **userdata:**  
    #!/bin/bash  
    yum update -y  
    yum install httpd -y  
    systemctl enable httpd && systemctl start httpd  
    sudo yum install -y amazon-efs-utils  
    mkdir /efs  
    sudo mount -t efs -o tls fs-xxxxxxxxxxxxx:/ /efs  
    >Esse script vai instalar o Apache com `yum install httpd -y`, inicia-lo com `systemctl enable httpd && systemctl start httpd`, instalar os pacotes necessários para o efs com `sudo yum install -y amazon-efs-utils`, cria a pasta /efs com `mkdir /efs`, monta o EFS com `sudo mount -t efs -o tls fs-xxxxxxxxxxxxx:/ /efs`, onde `fs-xxxxxxxxxxxxx` é o código de seu EFS.
    
  - **IP Elástico:**  
    44.195.168.181
    
  - **Par de Chaves:**
    RSA
    
### **Depois de criada a instância:**
  1. Crie o script `ApacheFunciona.sh`, neste repositório ele se encontra no diretório raiz. 
  2. O script precisa de permissão para ser executado, no caso `sudo chmod +x ApacheFunciona.sh` será suficiente.
  3. É necessário colocar o EFS no arquivo fstab, para que ele monte automáticamente na inicialização da instância. Podemos fazer isto modificando o arquivo `/etc/fstab`, inserindo `fs-XXXXXXXX:/ /efs efs defaults,_netdev 0 0` em uma nova linha.
  4. Mova o script `ApacheFunciona.sh` para o diretório `/efs`, com o comando `sudo mv ApacheFunciona.sh /efs` 
  5. Para que o script seja executado a cada 5 minutos, será necessário modificar o `crontab`, podemos acessar este arquivo com o comando `crontab -e`, possivelmente o arquivo aberto estará em branco. Para executar adicionar a linha `*/5 * * * *  bash /efs/ApacheFunciona.sh`, para que o bash execute o execute o script `ApacheFunciona.sh` à cada 5 minutos.
  6. Reinicie o crond para que suas alterações tenham efeito com `sudo service crond restart`
  7. A modificação dos arquivos de configuração do Apache é necessária para que o arquivo index.html, presente no EFS seja usado. Primeiramente devemos modificar o arquivo "/etc/httpd/conf/httpd.conf", mudando a linha `DocumentRoot "/var/www/html"` para `DocumentRoot "/efs"`.
  8. Reinicie o apache para que suas alterações tenham efeito com `sudo service httpd restart`
