#!/bin/bash

# Verifica que se hayan proporcionado los argumentos necesarios
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre_del_proceso> <comando_para_ejecutar>"
    exit 1
fi

nombre_proceso=$1
comando=$2

# Función para verificar si el proceso está corriendo
proceso_corriendo() {
    pgrep -x "$nombre_proceso" > /dev/null
}

# Función para iniciar el proceso si no está corriendo
iniciar_proceso() {
    echo "Iniciando el proceso $nombre_proceso..."
    $comando &
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
