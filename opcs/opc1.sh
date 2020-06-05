#Opção um do projeto principal - Cria uma nova pasta e adiciona ao 
#compartilhamento samba, sendo esse compartilhamento 
#somente para leitura ou um com permissões de escrita. 
#Inserir usuário que tera acesso ao compartilhamento, ou criar um novo.

nomepasta=$( dialog --stdout\
 --inputbox 'Infomre o nome da nova pasta que deve ser criada e compartilhada: ' \
 0 0)

if ( echo "$OPC" | grep -q '' ); then
        echo 'ERRO: Nome da pasta contém espaços
		inválido'
        exit 1
else
	CAM="/etc/samba/smb.conf"
    #Primeiro passo - Nome do compartilhamento - local - usuario - criando a pasta
    usuarioatual=$(who | cut -d" " -f1)
    
    npasta=$(dialog --stdout --title 'Nome da pasta' \
    --inputbox "Olá $usuarioatual. Digite o caminho completo e nome para a nova pasta. EX: /home/nomeusuario/pasta" 0 0)
    mkdir $npasta
    chmod o+w $npasta

    npastacimples=$(dialog --stdout --title 'Nome do compartilhamento' \
    --inputbox 'Digite o nome da pasta que aparecera como compartilhada. EX: Pasta' 0 0)
    
    nuser=$(dialog --stdout --title 'Usuário' --inputbox 'Digite o nome do usuário que deve ter acesso a pasta:')    
    #clear
    #echo 'Digite a baixo a senha para o usuario'
    #dialog --stdout --title 'Senha do usuário' --inputbox 'Digite a senha para o usuário do compartilhamento' 0 0
    dialog --msgbox 'Clique em OK e insira a baixo senha para o usuário do compartilhamento'
    smbpasswd -a -s $nuser
    
    comment=$(dialog --stdout --title 'Comentaário' --inputbox 'Insira um comentário para o compartilhamento' 0 0)

    #Segundo passo - estrutura do compartilhamento no smb.conf
    echo "[$npastasimples]
        comment=$comment
        path=$npasta
        browseable=yes
        writeable=yes
        allow users=$nuser" >> /etc/samba/smb.conf 
    dialog --title 'Resultado final no smb.conf' --textbox /etc/samba/smb.conf 0 0
    sudo systemctl reboot smbd
    clear
    sudo systemctl status smbd 
fi
