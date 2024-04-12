#!/bin/bash

# Verifica que se haya proporcionado un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <PID>"
    exit 1
fi

# Obtiene el PID del argumento
pid=$1

# Verifica si el proceso está corriendo
if ! ps -p $pid > /dev/null; then
    echo "El proceso con PID $pid no está corriendo."
    exit 1
fi

# Obtiene la información del proceso
nombre=$(ps -p $pid -o comm=)
ppid=$(ps -p $pid -o ppid=)
usuario=$(ps -p $pid -o user=)
uso_cpu=$(ps -p $pid -o %cpu=)
memoria=$(ps -p $pid -o %mem=)
estado=$(ps -p $pid -o state=)
path=$(readlink /proc/$pid/exe)

# Muestra la información obtenida
echo "Nombre del proceso: $nombre"
echo "ID del proceso: $pid"
echo "Parent process ID: $ppid"
echo "Usuario propietario: $usuario"
echo "Porcentaje de uso de CPU: $uso_cpu"
echo "Consumo de memoria: $memoria"
echo "Estado: $estado"
echo "Path del ejecutable: $path"

