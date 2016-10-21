#!/bin/bash

#pega o nome de usuario para saber se é root ou normal
usuario=`id -u`

#opções dos tamanhos da tela e menu
HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=40
BACKTITLE="Seja bem vindo"
TITLE="Configurar REDE"
MENU="Escolha uma das opcoes:"

#regra de repetição faca enquanto não for digitado o numero 4

while true
do
	OPTIONS=(1 "Configurar minha placa de rede para DHCP"
       		 2 "Alterar o nome do computador para nome"
        	3 "Alterar o nome do computador para nome_sobrenome"
		4 "Sair")

	CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" --stdout\
                )
                # 2>&1 >/dev/tty)

	clear
#case das opções
	case $CHOICE in
        	1)
			if [ $usuario -eq 0 ]
			then
				ip link set dev eth0 down 2>&1 > /tmp/temp.txt
				dhclient eth0 2>&1 >> /tmp/temp.txt
				ip r s 2>&1 >> /tmp/temp.txt
			else
				sudo ip link set dev eth0 down 2>&1 > /tmp/temp.txt
				sudo dhclient eth0 2>&1 >> /tmp/temp.txt
				sudo ip r s 2>&1 >> /tmp/temp.txt
			fi
			clear
			dialog --title 'Saida dos comandos' --textbox /tmp/temp.txt 20 60
			rm -f /tmp/temp/txt
            		;;
        	2)
			nome=$( dialog --stdout --inputbox 'Digite o nome:' 0 0 )
			if [ -n "$nome" ]
			then
				if [ $usuario -eq 0 ]
				then
					hostname $nome
				else
					sudo hostname $nome
				fi
				nome=`hostname`
				dialog --title 'Saida dos comandos' --msgbox "Nome do computador configurado para $nome" 20 60
			else
				dialog --title 'Saida dos comandos' --msgbox "Voce nao digitou nada..." 20 60
			fi
            		;;
        	3)
			nome=$( dialog --stdout --inputbox 'Digite o nome:' 0 0 )
			if [ -n "$nome" ]
			then
				sobrenome=$( dialog --stdout --inputbox 'Digite o sobrenome:' 0 0 )
				if [ -n "$sobrenome" ]
				then
					separador="_"
					maquina=$nome$separador$sobrenome

					if [ $usuario -eq 0 ]
					then
						hostname $maquina
					else
						sudo hostname $maquina
					fi
					nome=`hostname`
					dialog --title 'Saida dos comandos' --msgbox "Nome do computador configurado para $maquina" 20 60
				else
					dialog --title 'Saida dos comandos' --msgbox "Voce nao digitou nada..." 60 60
				fi
			else
				dialog --title 'Saida dos comandos' --msgbox "Voce nao digitou nada..." 20 60
			fi
            		;;
        	4)
			break
            		;;
        	*)
			break
            		;;
	esac
done

exit 0
