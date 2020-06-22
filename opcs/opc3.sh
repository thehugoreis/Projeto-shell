#!/bin/bash
#Terceira opção onde será acessado um compartilhamento samba

smbNip=$(dialog --stdout --title 'IP do compartilhamento' --inputbox 'Informe o endereço IP:' 0 0)

smbclient -L $smbNip -N > smb-lista.sh
dialog --textbox smb-lista.sh 0 0

smbNnome=$(dialog --stdout --title 'Nome do compartilhamento' --inputbox 'Informe o nome da pasta para acessar o compartilhamento:' 10 60)

smbNuser=$(dialog --stdout --title 'Usuario' --inputbox 'Informe o nome do usuário para acesso:' 10 45)
smbNsenha=$(dialog --stdout --title 'Senha' --passwordbox 'Informe  a senha do compartilhamento' 10 40)
echo ""
smbclient -U $smbNuser%$smbNsenha //$smbNip/$smbNnome
