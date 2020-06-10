dialog --yesno 'Quer adicionar o site a tabela hosts? Ex: localhost/site.com site.com' 0 0

if [ $? = 0 ]; then
    echo "localhost/sitedois.com sitedois.local" >> /etc/hosts
    dialog --msgbox 'Adicionado com sucesso' 0 0
else
    dialog --msgbox 'Não adicionado - Programa finalizado' 0 0
fi
