#!/bin/bash
#Opção 2 - Configura e adiciona mais um site/domínio as configurações do apache

apNpasta=$(dialog --stdout --title 'Nome da pasta' --inputbox 'Informe o nome da pasta para o site: Ex: site.com' 0 0)
mkdir -p /var/www/$apNpasta
dialog --msgbox "Uma pagina inicial com o nome index.html será criada dentro do diretório $apNpasta" 0 0
echo "<html>
  <head>
    <title>Site $apNpasta </title>
  </head>
  <body> <h1>Successo! Site de $apNpasta está funcinal!</h1>
  </body>
</html>" > /var/www/$apNpasta/index.html

dialog --title 'Arquivo index.html da pagina' --textbox /var/www/$apNpasta/index.html 0 0

dialog --msgbox 'Informe os dados para o arquivo que cria o host virtual do site' 0 0

apSadmin=$(dialog --stdout --title 'ServerAdmin' --inputbox 'Informe o ServerAdmin: Ex: admin@exemplo.com' 0 0)
apSname=$(dialog --stdout --title 'ServerName' --inputbox 'Informe o nome do serivor: Ex: exemplo.com' 0 0)

echo "<VirtualHost *:80>
    ServerAdmin $apSadmin
    ServerName $apSname
    ServerAlias www.$apSname
    DocumentRoot /var/www/
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/$apNpasta.conf 

dialog --title 'Arquivo do host virtual da pagina' --textbox /etc/apache2/sites-available/$apNpasta.conf 0 0 

a2ensite $apNpasta.conf > status-a2ensite.txt
dialog --textbox status-a2ensite.txt 0 0
systemctl restart apache2
systemctl status apache2 > status-apache2.txt
dialog --testbox status-apache2.txt 0 0

#dialog --yesno 'Quer adicionar o site a tabela hosts? Ex: localhost/site.com site.com' 0 0

#if [ $? = 0 ]; then
#    echo "localhost/$apNpasta $apNpasta" >> /etc/hosts
#    dialog --msgbox 'Adicionado com sucesso' 0 0
#else
#    dialog --msgbox 'Não adicionado - Programa finalizado' 0 0
#fi

dialog --yesno 'Deseja abri o site criado agora no firefox?' 0 0

if [ $? = 0 ]; then
    firefox localhost/$apNpasta &
    dialog --msgbox 'Abrindo link no browser' 0 0
else
    dialog --msgbox 'ok, finalizando programa' 0 0
fi
clear
