#!/bin/bash

# Verifica que se hayan proporcionado los argumentos necesarios
if [ $# -ne 1 ]; then
    echo "Uso: $0 <comando_con_duración>"
    exit 1
fi

comando_con_duración=$1

# Obtener el nombre del proceso del comando
nombre_proceso=$(echo "$comando_con_duración" | awk '{print $1}')

# Función para verificar si el proceso está corriendo
proceso_corriendo() {
    pgrep -x "$nombre_proceso" > /dev/null
}

# Función para iniciar el proceso si no está corriendo
iniciar_proceso() {
    echo "Iniciando el proceso $nombre_proceso..."
    $comando_con_duración &
}

# Bucle principal
while true; do
    # Verificar si el proceso está corriendo
    if proceso_corriendo; then
        echo "El proceso $nombre_proceso ya está corriendo."
    else
        echo "El proceso $nombre_proceso no está corriendo. Iniciándolo..."
        iniciar_proceso
    fi
    # Dormir durante 15 segundos antes de verificar nuevamente
    sleep 15
done
