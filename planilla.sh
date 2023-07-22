#!/bin/bash
cd $HOME/Descargas/
		 if [ -e Reporte_Recibos.csv ]
                 then

		 awk -F "," '{print ($1 ",", $5 ",", $2 ",", $9 ",", $7 ",", $6 ",", $4 ",", $8)}' Reporte_Recibos.csv > planilla_ingresos.csv && cat planilla_ingresos.csv
                 
                        echo "Archivo Creado con Exito. Bajado en la carpeta =>"
			echo "/Descargas/planilla_ingresos.csv"
                 else
                        echo "No existe el archivo a Consultar, procure bajarlo nuevamente" 2>/dev/null
                 fi

cd $HOME
