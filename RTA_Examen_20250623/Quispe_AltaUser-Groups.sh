#!/bin/bash

USUARIOBASE=$1
LISTA=$2

# Verificar que se pasaron ambos parámetros
if [ $# -ne 2 ]; then
  echo "Uso: $0 <usuario_referencia> <archivo_lista_usuarios>"
  exit 1
fi

# Obtener la clave cifrada del usuario base
CLAVE=$(sudo getent shadow "$USUARIOBASE" | cut -d: -f2)

if [ -z "$CLAVE" ]; then
  echo "Error: No se pudo obtener la clave del usuario $USUARIOBASE"
  exit 2
fi

# Recorrer el archivo y procesar usuarios y grupos
OLDIFS=$IFS
IFS=$'\n'

for LINEA in $(grep -v '^#' "$LISTA"); do
  USUARIO=$(echo "$LINEA" | awk -F ',' '{print $1}')
  GRUPO=$(echo "$LINEA" | awk -F ',' '{print $2}')

  # Crear grupo si no existe
  if ! getent group "$GRUPO" > /dev/null; then
    sudo groupadd "$GRUPO"
  fi

  # Crear usuario si no existe
  if ! id "$USUARIO" > /dev/null 2>&1; then
    sudo useradd -m -s /bin/bash -g "$GRUPO" -p "$CLAVE" "$USUARIO"
  fi
done

IFS=$OLDIFS
