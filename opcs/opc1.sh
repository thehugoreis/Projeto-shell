#Opção um do projeto principal - Cria uma nova pasta e adiciona ao 
#compartilhamento samba, sendo esse compartilhamento 
#somente para leitura ou um com permissões de escrita. 
#Inserir usuário que tera acesso ao compartilhamento, ou criar um novo.

#nomepasta=$( dialog --stdout\
# --inputbox 'Infomre o nome da nova pasta que deve ser criada e compartilhada: ' \
# 0 0)

#usuarioatual=$(who | cut -d" " -f1)

npasta=$(dialog --stdout --title 'Nome da pasta' \
--inputbox "Olá $USER. Digite o caminho completo e nome para a nova pasta. EX: /home/nomeusuario/pasta" 15 100)

if [ -z $npasta ]; then
        clear
        echo 'ERRO: Nome da pasta contém espaços
		inválido'
        exit 1
        
else
	CAM="/etc/samba/smb.conf"
    #Primeiro passo - Nome do compartilhamento - local - usuario - criando a pasta
    mkdir $npasta
    chmod o+w $npasta

    npastasimples=$(dialog --stdout --title 'Nome do compartilhamento' \
    --inputbox 'Digite o nome da pasta que aparecera como compartilhada. EX: Pasta' 0 0)
    
    nuser=$(dialog --stdout --title 'Usuário' --inputbox 'Digite o nome do usuário que deve ter acesso a pasta:' 10 60)    
    #clear
    #echo 'Digite a baixo a senha para o usuario'
    #dialog --stdout --title 'Senha do usuário' --inputbox 'Digite a senha para o usuário do compartilhamento' 0 0
    #dialog --msgbox 'Clique em OK e insira a baixo senha para o usuário do compartilhamento' 10 100
    #clear
    #smbpasswd -a -s $nuser

    nsenha=$(dialog --stdout --title "Senha para o usuário $nuser" --inputbox \
	    'Digite uma senha para o usuário do compartilhamento:' 10 60)
    echo -e "$nsenha\n$nsenha\n\n\n\n\ny\n" | adduser $nuser
    echo -e "$nsenha\n$nsenha" | smbpasswd -a -s $nuser
    
    comment=$(dialog --stdout --title 'Comentaário' --inputbox 'Insira um comentário para o compartilhamento' 10 60)

    #Segundo passo - estrutura do compartilhamento no smb.conf
    echo "[$npastasimples]
        comment=$comment
        path=$npasta
        browseable=yes
        writeable=yes
        allow users=$nuser" >> /etc/samba/smb.conf 
    dialog --title 'Resultado final no smb.conf' --textbox /etc/samba/smb.conf 0 0
    sudo systemctl restart smbd
    clear
    sudo systemctl status smbd > smb-status.txt
    dialog --textbox smb-status.txt 0 0
    #senhadogrupo=$(dialog --title 'Informe a senha do grupo de trabalho' \
#	    --inputbox 'Essa senha é geralmente a senha de root' 0 0)
    echo -e "\n" | smbclient -L localhost > status-smbclient.txt
    dialog --textbox status-smbclient.txt 0 0
    clear
fi
