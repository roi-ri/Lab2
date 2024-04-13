#!/bin/bash

# Directorio a monitorear
DIRECTORIO="/home/user/documents"

# Archivo de log
LOG_FILE="/var/log/directory_changes.log"

# Ejecutar inotifywait para monitorear el directorio
inotifywait -m -r -e create,modify,delete --format "%T %w %e %f" "$DIRECTORIO" >> "$LOG_FILE" 2>&1
