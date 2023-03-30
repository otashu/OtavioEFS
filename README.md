# OtavioEFS
## Criando uma instancia com um EFS na aws, configurando apache e fazendo um script que avisa se o servidor está online ou offline. 

### *Primeiro criei um EFS, para poder configura-lo no user data da instância no momento de sua criação, junto com o apache para facilitar o processo.*

### *Detalhes da Instância:* 
  - **SO: Amazon Linux 2 (Família t3.small)**

  - **Portas Liberadas no SG:**
    * 22/TCP
    * 111/TCP
    * 111/UDP
    * 2049/TCP
    * 2049/UDP
    * 80/TCP
    * 443/TCP
  
  - **Volume:**  
    1x16GB gp2

  - **userdata:**  
    #!/bin/bash  
    yum update -y  
    yum install httpd -y  
    systemctl enable httpd && systemctl start httpd  
    sudo yum install -y amazon-efs-utils  
    mkdir /efs  
    sudo mount -t efs -o tls fs-064979e66c91d498e:/ /efs  
    
### **Depois de criada a instância:**
  1. instalei o git
  2. iniciei o crond 
  3. iniciei a criação do script ApacheFunciona.sh
  4. dei as permições necessárias para o script (sudo chmod +x ApacheFunciona.sh)
  5. configurei o git
  6. configurei o EFS no fstab
  7. coloquei o script no crontab, primeiramente para rodar a cada 1 min, para testes
