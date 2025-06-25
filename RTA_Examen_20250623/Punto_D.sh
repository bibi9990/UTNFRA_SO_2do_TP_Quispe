#!/bin/bash

# Navegar a la carpeta del playbook
cd /UTN-FRA_SO_Examenes/202406/ansible/

# Ejecutar el playbook localmente
ansible-playbook -i localhost, -c local playbook.yml

# Mostrar contenido generado
echo -e "\n Contenido de /tmp/2do_parcial/alumno:"
cat /tmp/2do_parcial/alumno/datos_alumno.txt

echo -e "\n Contenido de /tmp/2do_parcial/equipo:"
cat /tmp/2do_parcial/equipo/datos_equipo.txt
