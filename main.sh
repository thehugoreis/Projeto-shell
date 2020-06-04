#Menu principal do projeto
#ver 1.0
#!/bin/bash

OPC=$(dialog --stdout\
   --title 'Menu principal'\
   --menu 'Escolha uma das funções disponiveis:'\
   0 0 0\
   1 '- Criar novo compartilhamento SAMBA'\
   2 '- Criar nova pasta e HTML no APACHE'\
   3 '- Acessar compartilhamento SAMBA com smbclient'\
   4 '- Sair')

CAM=("opcs/")

case $OPC in
        1) 
		echo -n 'Abrindo opção selecionada...'
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && \
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && \
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && sleep 1 && echo "..."
		$CAM/opc1.sh
        ;;
        2) 
		echo -n 'Abrindo opção selecionada...'
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && \
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && \
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && sleep 1 && echo "..."
		$CAM/opc2.sh
		;;
        3) 
		echo -n 'Abrindo opção selecionada...'
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && \
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && \
		sleep 1 && echo -n "......." && sleep 1 && echo -n "......." && sleep 1 && echo "..."
		$CAM/opc3.sh
		;;
        4) 
		echo 'Saindo do programa'
		;;
        *) 
		echo'opção inválida'
		;;
esac
