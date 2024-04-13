#!/bin/bash

# Verifica que se haya proporcionado un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ejecutable>"
    exit 1
fi

# Nombre del ejecutable proporcionado como argumento
ejecutable=$1

# Nombre del archivo de registro
log_file="registro_$1.txt"

# Función para obtener el consumo de CPU y memoria del proceso
obtener_consumo() {
    ps -p $pid -o %cpu,%mem | tail -n 1
}

# Ejecutar el binario y obtener su PID
echo "Ejecutando $ejecutable..."
$ejecutable &
pid=$!

# Crear archivo de registro
echo "Tiempo CPU(%) Memoria(%)" > $log_file

# Bucle para monitorear el proceso y registrar el consumo
while ps -p $pid > /dev/null; do
    tiempo=$(date +%s)  # Marca de tiempo actual en segundos desde el epoch
    consumo=$(obtener_consumo)
    echo "$tiempo $consumo" >> $log_file
    sleep 1
done

# Graficar los valores registrados utilizando gnuplot
gnuplot << EOF
    set xlabel "Tiempo (segundos desde el inicio)"
    set ylabel "Consumo"
    set title "Consumo de CPU y Memoria de $ejecutable"
    set terminal png
    set output "grafico_$ejecutable.png"
    plot "$log_file" using 1:2 with lines title "CPU", \
         "$log_file" using 1:3 with lines title "Memoria"
EOF

# Imprimir la ruta del archivo de imagen generado
echo "Se ha generado el gráfico en $(pwd)/grafico_$ejecutable.png"
