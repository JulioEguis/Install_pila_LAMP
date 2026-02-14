#!/bin/bash

# Script de instalación de LAMP en Linux
echo "Instalador de LAMP para Ubuntu"

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
    echo "ejecuta este script como root o usando sudo"
    exit 1
fi
