#!/bin/bash

# Archivo donde se guardarán los comandos
LOG_FILE="comandos_xaceel.txt"

# Limpia el archivo antes de escribir
> "$LOG_FILE"

# Busca procesos ffmpeg y extrae el comando completo
ps aux | grep '[f]fmpeg' | awk '{print $2}' | while read -r pid; do
    # Extrae la línea de comando completa usando /proc/<pid>/cmdline
    if [[ -r /proc/$pid/cmdline ]]; then
        cmd=$(tr '\0' ' ' < /proc/$pid/cmdline)
        echo "PID: $pid" >> "$LOG_FILE"
        echo "Comando: $cmd" >> "$LOG_FILE"
        echo "----------------------" >> "$LOG_FILE"
    fi
done

echo "Comandos de ffmpeg exportados a $LOG_FILE"
