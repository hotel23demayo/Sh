#!/bin/bash

echo "Buscando Reservas para hoy ..."
sleep 2

cd $HOME/Descargas/

if [ -e consultaRegimenReport.csv ]; then
    awk -F "," '{
        if ($24 != "O") {
            print $3 ",", $9 ",", $10 ",", $6 ",", $12 ",", $13 ",", $14 ",", $15 ",", $7 ",", $17 ",", $24 ",", $18 ",", $8 ",", $5
        }
    }' consultaRegimenReport.csv > reserva_hoy.csv
    
    echo "Archivo \"reserva_hoy\" descargado. Encontralo en la carpeta => "
    echo "/Descargas/reserva_hoy.csv "
else
    echo "No existe el archivo a Consultar, procure bajarlo nuevamente" 2>/dev/null
fi

cd $HOME

