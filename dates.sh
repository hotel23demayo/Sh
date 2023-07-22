#!/bin/bash
$1=""
$2=""

let DIFF=($(date +%s -d $2)-$(date +%s -d $1))/86400
echo $DIFF

filename="final.txt"
		 while read -r din dout cantd; do
		 #name="$name"
		 #dni="$dni"
		 #room="$room"
		 din="$din"
		 dout="$dout"
		 cantd="$cantd"
		 printf "\n\n\n\n\n\n\n"

		 printf "Apellido y Nombre \t $name%s\t\t\t DNI $dni%s"
		 printf "\nHotel 23 de Mayo \t\t Ingreso $din%s\t Salida  $dout%s" 
		 #printf "\nNº Voucher $nvoucher%s"
		 printf "\nHabitacion Nº $room %s"
		 printf "\n\t\t\t\t Cant $cantd%s \n\n\n\n\n\n\n\n\n\n\n"

		 done < "$filename" > ~/Escritorio/Voucher/cant_map.txt
