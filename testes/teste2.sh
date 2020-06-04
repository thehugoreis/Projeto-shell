#usuario=$(who | cur -d" " -f1)
#caminho=$(home/$usuario/)
echo -n 'informe o caminho para criar a pasta: '
read caminho 
echo $caminho
echo "deseja ir atéo caminho $caminho ?"
read resp
if [ $resp -eq 1 ]
then
	cd $caminho
else
	echo 'saindo do programa'
fi
