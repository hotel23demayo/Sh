#!/bin/bash

filename="voucher1.csv"

declare -A accompaniment

while IFS=',' read -r fullname dni din dout room cantp; do
    # Extraer el apellido del nombre completo
    lastname=${fullname%% *}

    printf "\n\n\n\n\n\n\n"
    
    printf "Apellido: \t%s\t DNI: %s\n" "$lastname" "$dni"
    printf "Habitación Nº %s\n" "$room"
    printf "Hotel 23 de Mayo \t Ingreso: %s\t Salida: %s\n" "$din" "$dout"
    printf "\t\t\t\t Cant: %s\n\n\n\n\n\n\n\n\n\n\n" "$cantp"

    # Validar si la habitación se repite y la fecha de salida es la misma
    if [[ ${accompaniment[$room]} == $dout ]]; then
        printf "\n¡Acompañante!\n\n"
    fi

    # Almacenar la fecha de salida para la habitación actual
    accompaniment[$room]=$dout
done < "$filename" > ~/Escritorio/Voucher/cant_map.txt

