#!/bin/bash

# Verificar que se proporcionaron los argumentos necesarios
if [ $# -ne 2 ]; then
    echo "Uso: $0 <carpeta> <nombre_zip>"
    exit 1
fi

# Obtener la carpeta que se resguarda del primer argumento.
carpeta="$1"

# Ruta donde se guardará el archivo ZIP
ruta_destino="/root/backup/"

# Fecha límite para la modificación de archivos (hace 7 días)
fecha_limite=$(date -d "7 days ago" "+%Y-%m-%d")

# Nobre del zip incluyendo la fecha limite
nombre_zip="$2_$fecha_limite.zip"

# Crear una lista de archivos modificados o creados en los últimos 2 días
archivos_modificados=$(find "$carpeta" -type f -newermt "$fecha_limite")

# Crear el archivo ZIP con los archivos modificados
zip -r "$ruta_destino$nombre_zip" $archivos_modificados

# echo "El archivo ZIP '$nombre_zip' ha sido creado con éxito en '$ruta_destino'."
