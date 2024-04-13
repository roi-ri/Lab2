#!/bin/bash

# Verifica que se haya proporcionado un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ejecutable>"
    exit 1
fi

# Nombre del ejecutable
ejecutable=$1

# Nombre del archivo de registro
archivo_log="consumo_${ejecutable}_$(date +'%Y%m%d_%H%M%S').log"

# Ejecutar el binario recibido
echo "Ejecutando el binario $ejecutable..."
./$ejecutable &

# PID del proceso ejecutado
pid=$!

# Cabecera del archivo de log
echo "Timestamp CPU(%)" > $archivo_log

# Bucle para monitorear y registrar el consumo de CPU
while ps -p $pid > /dev/null; do
    timestamp=$(date +'%Y-%m-%d %H:%M:%S')
    cpu_usage=$(ps -p $pid -o %cpu=)
    echo "$timestamp $cpu_usage" >> $archivo_log
    sleep 1
done

# Graficar los valores utilizando gnuplot
echo "Generando gráfico..."
gnuplot <<- EOF
    set terminal png
    set output 'consumo_${ejecutable}.png'
    set title 'Consumo de CPU de $ejecutable'
    set xlabel 'Tiempo'
    set ylabel 'Porcentaje de CPU'
    set xdata time
    set timefmt '%Y-%m-%d %H:%M:%S'
    set format x '%H:%M:%S'
    plot '$archivo_log' using 1:2 with lines title 'CPU'
EOF

echo "Proceso finalizado. Gráfico generado en consumo_${ejecutable}.png"

