#!/bin/bash

# Verificar que se haya proporcionado la ruta al directorio que contiene el archivo wp-config.php como argumento
if [[ $# -ne 1 ]]; then
    echo "Uso: $0 <ruta_al_directorio_wp_config>"
    exit 1
fi

# Ruta al directorio que contiene el archivo wp-config.php
WP_CONFIG_DIR="$1"

# Verificar si el directorio existe
if [[ ! -d $WP_CONFIG_DIR ]]; then
    echo "El directorio $WP_CONFIG_DIR no existe."
    exit 1
fi

# Concatenar el nombre del archivo wp-config.php a la ruta proporcionada
WP_CONFIG="$WP_CONFIG_DIR/wp-config.php"

# Extraer los valores de DB_NAME, DB_USER y DB_PASSWORD del archivo wp-config.php
DB_NAME=$(grep "'DB_NAME'" "$WP_CONFIG" | awk -F "'" '{print $4}')
DB_USER=$(grep "'DB_USER'" "$WP_CONFIG" | awk -F "'" '{print $4}')
DB_PASSWORD=$(grep "'DB_PASSWORD'" "$WP_CONFIG" | awk -F "'" '{print $4}')

# Verificar si se obtuvieron todos los valores correctamente
if [[ -z $DB_NAME || -z $DB_USER || -z $DB_PASSWORD ]]; then
    echo "No se pudieron obtener los valores de DB_NAME, DB_USER o DB_PASSWORD del archivo wp-config.php."
    exit 1
fi

# Obtener la fecha actual en formato YYYY-MM-DD
FECHA=$(date +%Y-%m-%d)

# Nombre del archivo de salida con la fecha
OUTPUT_FILE="$DB_NAME-$FECHA.sql"

# Hacer el volcado de la base de datos usando mysqldump
mysqldump --no-tablespaces -u "$DB_USER" -p"$DB_PASSWORD" -h 10.116.0.5 "$DB_NAME" > "$OUTPUT_FILE"

# Verificar si el volcado fue exitoso
if [[ $? -eq 0 ]]; then
    
    # Comprimir el archivo SQL en un archivo ZIP
    zip -r "/root/backup/$OUTPUT_FILE.zip" "$OUTPUT_FILE"
    
    # Verificar si la compresión fue exitosa
    if [[ $? -eq 0 ]]; then
        
        # Eliminar el archivo SQL original
        rm "$OUTPUT_FILE"
    else
        echo "Error al comprimir el archivo SQL."
        exit 1
    fi
else
    echo "Error al hacer el volcado de la base de datos."
    exit 1
fi
