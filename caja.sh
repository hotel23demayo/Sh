#!/bin/bash

echo "Caja del Dia - Movimientos en efectivo ..."
sleep 2
cd $HOME/Descargas/
touch raw.csv efvo.csv && cut -d"," -f1,2,4,6 Reporte_Recibos.csv | cat > raw.csv | sed -i 's/0192-RB-000/0/' raw.csv  && cat raw.csv | grep -i "caja seccional" raw.csv |cat > efvo.csv | awk -F ',' '{sum+=$4;} END {print sum;}' efvo.csv | cat > efvo.csv && cat efvo.csv
cd $HOME
