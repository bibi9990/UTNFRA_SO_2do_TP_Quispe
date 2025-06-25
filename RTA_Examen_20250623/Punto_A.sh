Punto A - LVM para almacenamiento de docker, areas de trabajo y swap 
alumno: blanca quispe
fecha: 2025-06-23

para volumenes fisicos:
sudo pvcreate /dev/sdc1
sudo pvcreate /dev/sdd1
sudo pvcreate /dev/sdd2

para grupos de volumenes:
sudo vgcreate vg_datos /dev/sdc1 /dev/sdd1
sudo vgcreate vg_temp /dev/sdd2

para volumenes logicos:
sudo lvcreate -L 8M    -n lv_docker    vg_datos
sudo lvcreate -L 1.3G  -n lv_workareas vg_datos
sudo lvcreate -L 508M  -n lv_swap      vg_temp

para sistemas de archivos:
sudo mkfs.ext4 /dev/vg_datos/lv_docker
sudo mkfs.ext4 /dev/vg_datos/lv_workareas

para puntos de montaje:
sudo mkdir -p /var/lib/docker
sudo mkdir -p /work

para montar volumenes: 
sudo mount /dev/vg_datos/lv_docker /var/lib/docker
sudo mount /dev/vg_datos/lv_workareas /work

para configurar swap: 
sudo mkswap /dev/vg_temp/lv_swap
sudo swapon /dev/vg_temp/lv_swap

