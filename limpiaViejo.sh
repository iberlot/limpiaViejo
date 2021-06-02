#!/bin/bash
# -*- ENCODING: UTF-8 -*-

while true; do
	echo
	read -p "Cuantos dias de atiguedad tienen que tener los archivos? " dias

	es_numero='^-?[0-9]+([.][0-9]+)?$';

	if  [[ $dias =~ $es_numero ]]; then
		break;
	fi
	echo "ERROR: No es un número"
done

if test -n "$1" ; then
	extencion="-name *."$1
else
	extencion="";
fi

cantidad=$(find ./* $extencion -mtime +$dias -type f | wc -l)

if [[ $cantidad > 0 ]]; then
	echo "Se encontraron $cantidad archivos"
	echo "Se eliminaran los siguientes archivos"

	find ./* $extencion -mtime +$dias -type f -print

	while true; do
		echo
		read -p "Esta seguro que desea eliminar estos archivos? y/n " yn
		case $yn in
			y ) break;;
			n ) exit;;
			* ) echo "por favor responda y o n";;
		esac
	done
	
	find ./* $extencion -mtime +$dias -type f -delete
	echo "si se ejecuta esto es que aceptaste y se borro todo"
else
	echo "No hay archivos con esas caracteristicas"
fi