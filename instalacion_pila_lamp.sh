#!/bin/bash

# Script de instalación de LAMP en Linux
echo "Instalador de LAMP"

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
    echo "ejecuta este script como root o usando sudo"
    exit 1
fi

# actualizar sistema y que no pida la confirmación
echo "Actualizando el sistema..."
apt update && apt upgrade -y

# instalar Apache
echo "Instalando Apache..."
apt install apache2 -y
systemctl enable apache2
systemctl start apache2

# instalar Mysql
echo "Instalando Mysql..."
apt install mysql-server -y
systemctl enable mysql
systemctl start mysql

# instalar PHP con la instalaciones basicas y con -y para que confirme todo
echo "Instalando PHP y módulos..."
apt install php libapache2-mod-php php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip -y

# configurar Apache y que cargue el modulo de php que instalamos
echo "Configurando Apache..."
a2enmod php
systemctl restart apache2

# crear archivo de prueba
cat > /var/www/html/info.php << 'EOF'
<?php
phpinfo();
?>
EOF

# información final de la instalación
echo ""
echo "*************************"
echo "LAMP instalado correctamente"
echo "*************************"
echo "Versión de Apache: $(apache2 -v | head -n 1)"
echo "Versión de MySQL: $(mysql --version)"
echo " Versión de PHP: $(php -v | head -n 1)"
echo ""
echo "Accede a: http://$(hostname -I | awk '{print $1}')"
echo "Info PHP: http://$(hostname -I | awk '{print $1}')/info.php"
echo ""
echo "Hay que ejecutar 'sudo mysql_secure_installation'"





