#!/bin/bash

# Verifica si se proporcionó un argumento (ruta de la carpeta)
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ruta_de_la_carpeta>"
    exit 1
fi

# Verifica si la carpeta existe
if [ ! -d "$1" ]; then
    echo "La carpeta especificada no existe."
    exit 2
fi

# Borra los archivos que sean anteriores a 14 días
if find "$1" -type f -mtime +14 -exec rm {} \; ; then
    echo "Archivos anteriores a 14 días eliminados correctamente."
    exit 0
else
    echo "Error al eliminar archivos anteriores a 14 días."
    exit 3
fi
