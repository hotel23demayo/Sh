#! /bin/bash
clear
figlet -c Suteba #bajar app figlet para ASCII ART

title="Aplicacion de Manejo de Archivos del SIGS"
columns=$(tput cols)
title_size=${#title}
proceed=$((($columns + $title_size) / 2))

#printf "%$(tput cols)s\n"|tr " " "#"
printf "%${proceed}s\n" "$title"
printf "%$(tput cols)s\n"|tr " " "-"

sleep 2
PS3="Elige una opcion: "
sections=("Preparar archivos" "Buscar Reserva" "Voucher" "Caja Diaria" "Planilla Ingresos" "Salir")
select fav in "${sections[@]}"; do
         case $fav in
                 "Preparar archivos")
                  echo "Borrando archivos anteriores ..."
		  sleep 2
                  cd $HOME/Descargas/
                  echo "Completado. Proceda a descargar los nuevos archivos a procesar. "
                  rm $HOME/Descargas/*.csv 2>/dev/null 

		  sleep 2
		  printf "%$(tput cols)s\n"
		  printf "%$(tput cols)s\n"|tr " " "#"
		  printf "%$(tput cols)s\n"


                  ;;

		 "Voucher")
                 echo "Buscando pasajeros con Map ... "
                 sleep 2
		 cd $HOME/Descargas/
		 awk '/PENSION COMPLETA/ {print}' reserva_hoy.csv > file_vou.csv && awk -F "," '{print ($7",", $6",", $1",", $2 ",", $3",", $4)}' file_vou.csv | sed 's/ //'g | sed 's/,/ /g' > finalisima.csv > finalisima.txt
		 awk '!seen[$NF]++' finalisima.txt > final.txt
		 cp reserva_hoy.csv $HOME
# desde aca contar pasajeros por nº de voucher
# desde aca contar dias de estadia

		 sleep 2
		
		 filename="final.txt"
		 while read -r name dni room din dout nvoucher; do
		 name="$name"
		 dni="$dni"
		 room="$room"
		 din="$din"
		 dout="$dout"
		 nvoucher="$nvoucher"
		 printf "\n\n\n\n\n\n\n"

		 printf "Apellido y Nombre \t $name%s\t\t\t DNI $dni%s"
		 printf "\nHotel 23 de Mayo \t\t Ingreso $din%s\t Salida  $dout%s" 
		 printf "\nNº Voucher $nvoucher%s"
		 printf "\nHabitacion Nº $room %s\n\n\n\n\n\n\n\n\n\n\n"

		 done < "$filename" > ~/Escritorio/Voucher/cant_map.txt
		
		 sleep 2
		 echo "Archivo listo para imprimir. Dentro de la carpeta =>"
		 echo "/Escritorio/Voucher/cant_map.txt"
                 sleep 2
		 printf "%$(tput cols)s\n"
		 printf "%$(tput cols)s\n"|tr " " "#"
		 printf "%$(tput cols)s\n"

		 ;;

		"Buscar Reserva")
	         echo "Preparando Archivo... "
                 sleep 2
                 cd $HOME/Descargas/

                 if [ -e consultaRegimenReport.csv ]
		 then
		 awk -F "," '{print ($3",", $9",", $10",", $6 ",", $12 ",", $13 ",", $14 " ,", $15 ",", $7 ",", $17 ",", $24 ",", $18 ",", $8 ",", $5)}' consultaRegimenReport.csv > reserva_hoy.csv
		# awk -F "," '{print ($3",", $9",", $10",", $6 ",", $12 ",", $13 ",", $14 " ,", $15 ",", $7 ",", $17 ",", $18 ",", $24)}' consultaRegimenReport.csv > reserva_hoy.csv
			echo "Archivo Creado con Exito"
		 else
			echo "No existe el archivo a Consultar, procure bajarlo nuevamente" 2>/dev/null
		 fi
		
		 sleep 2
		 printf "%$(tput cols)s\n"
		 printf "%$(tput cols)s\n"|tr " " "#"
		 printf "%$(tput cols)s\n"

		 ;;
		 


		"Caja Diaria")
                 echo "Caja del Dia "
                 cd $HOME/Descargas/

		 if [ -e Reporte_Recibos.csv ]
		 then
		 touch raw.csv efvo.csv && cut -d"," -f1,2,4,6 Reporte_Recibos.csv | cat > raw.csv | sed -i 's/0044-RB-000/0/' raw.csv  && cat raw.csv | grep -i "caja seccional" raw.csv |cat > efvo.csv | awk -F ',' '{sum+=$4;} END {print sum;}' efvo.csv | cat > efvo.csv && cat efvo.csv
                 #touch raw.csv tarj.csv && cut -d"," -f1,2,4,6 Reporte_Recibos.csv | cat > raw.csv | sed -i 's/0044-RB-000/0/' raw.csv  >
		 	echo "Rendicion del Dia"
		 else
			echo "No existe el archivo a Consultar, procure bajarlo nuevamente" 2>/dev/null
		 fi
                 sleep 5
                 echo "Rendicion Finalizada"
                
		
		 sleep 2
		 printf "%$(tput cols)s\n"
		 printf "%$(tput cols)s\n"|tr " " "#"
		 printf "%$(tput cols)s\n"

                 ;;

		"Planilla Ingresos")
		 echo "Movimientos del dia para bajarlos a Planilla de Ingresos... "
                 sleep 2

		 cd $HOME/Descargas/
		 if [ -e Reporte_Recibos.csv ]
                 then

		 awk -F "," '{print ($1 ",", $5 ",", $2 ",", $9 ",", $7 ",", $6 ",", $4 ",", $8)}' Reporte_Recibos.csv > planilla_ingresos.csv && cat planilla_ingresos.csv
                 
                        echo "Archivo Creado con Exito. Bajado en la carpeta =>"
			echo "/Descargas/planilla_ingresos.csv"
                 else
                        echo "No existe el archivo a Consultar, procure bajarlo nuevamente" 2>/dev/null
                 fi

		 sleep 2 
		 printf "%$(tput cols)s\n"
		 printf "%$(tput cols)s\n"|tr " " "#"
		 printf "%$(tput cols)s\n"


                 ;;

		"Salir")
                 echo "Cerrando Aplicación... "
                 sleep 2
                 cd $HOME/
		 printf "%$(tput cols)s\n"
		 printf "%$(tput cols)s\n"|tr " " "#"
		 printf "%$(tput cols)s\n"

                 
		 break 
		 ;;

		*)
                        echo "Invalid Option $REPLY"
                 ;;
	esac
done


