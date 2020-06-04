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
	#criando o compartilhamento
    
fi
