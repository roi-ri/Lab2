#!/bin/bash

# Directorio a monitorear
directorio_monitoreado="/home"

# Archivo de log para registrar los eventos de cambios
archivo_log="/home/roiri/log_lab2/datos.log"

# Mensaje de log con la fecha y hora del cambio
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Cambio detectado en $1: $2" >> "$archivo_log"
}

# Monitorear el directorio en busca de cambios continuamente
inotifywait -m -r -e create,modify,delete "$directorio_monitoreado" | while read evento; do
    log_message "$directorio_monitoreado" "$evento"
done
