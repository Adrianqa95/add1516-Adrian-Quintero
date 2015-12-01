Gregorio Adrián Quintero Álvarez

# 1 Samba - OpenSUSE

## 1.0 Introducción

En esta práctica vamos a necesitar tres máquinas virtuales, un servidor que será 
OpenSUSE y dos clientes que serán uno OpenSUSE y otro Windows 7. Estas máquinas t
tendrán que estar en estatico con esta configuración: 

- Servidor OpenSUSE 172.18.19.53
- Cliente OpenSUSE 172.18.19.54
- Cliente Windows 172.18.19.13

## 1.1 Preparativos

Ahora configuraremos las máquinas estableciendo en ellas como nombre de usuario
nuestro nombre y como clave de root en OpenSUSE y administrador de Windows nuestro
DNi.

En el servidor pondremos como nombre de equipo "Samba-server" y como 
nombre de dominio nuestro segundo apellido "Alvarez".

![Foto 1](1.png) 

En el cliente OpenSUSE pondremos como nombre de equipo "Samba-cli1" y como nombre de dominio
nuestro segundo apellido "Alvarez".

![Foto 2](2.png)

En el cliente Windows 7 como nombre de equipo pondremos "Samba-cli2-19".

![Foto 3](3.png)

También deberemos de añadir nuestra comfiguración al archivo hosts de nuestras máquinas.

- Servidor.

![Foto 1a](1a.png)

- Cliente OpenSUSE.

![Foto 2a](2a.png)

- Cliente Windows.

![Foto 3a](3a.png)

Ahora debemos de realizar una comprobación en el servidor con estos comandos:

hostname -f, ip a, lsblk, sudo blkid.

![Foto 4](4.png)

## 1.2 Usuarios Locales

En el servidor vamos a crear unos usuarios y unos grupos.

- Primero crearemos los usuarios "Jedi1, jedi2, sith1, sith2, supersamba".

![Foto 5](5.png)

Después crearemos el grupo "jedis" y "siths" en el cual meteremos los usuarios.

- Grupo Jedis

![Foto 6](6.png)

-Grupo Siths

![Foto 7](7.png)

Ahora crearemos el usuario "smbguest" y nos aseguramos de que nadie pueda entrar
a nuestra máquina mediante el login para eso modificamos el fichero /etc/passwd.

![Foto 8](8.png)

![Foto 10](10.png)

A continuación crearemos un grupo llamado "startwars" y dentro de el introduciremos
todos los usuarios que hemos creado anteriormente

![Foto 9](9.png)

## 1.3 Instalar Samba

Empezaremos con las instalación de samba mediante comando

![Foto 11](11.png)

## 1.4 Crear las carpetas para los recursos compartidos

Ahora vamos a crear las carpetas de los recursos compartidos  public.d corusant.d y tatooine con una serie de permisos:

![Foto 12](12.png)

## 1.5 Configurar Samba

A continuación vamos a hacer una copia de seguridad del fichero de configuración con el comando:

- cp /etc/samba/smb.conf /etc/samba/smb.conf.000.

![Foto 14](14.png)

Después vamos a configurar el servidor Samba con las siguientes opciones.

![Foto 15](15.png)

![Foto 16](16.png)

Comprobaremos los resultados  que todo está bien con testparm.

![Foto 17](17.png)

## 1.6 Usuarios Samba

Después de crear los usuarios en el sistema, hay que añadirlos a Samba. Para eso
hay que usar el comando siguiente para cada usuario de Samba: smbpasswd -a nombreusuario.

![Foto 18](18.png)

Al terminar comprobamos nuestra lista de usuarios Samba con el comando: pdbedit -L

![Foto 19](19.png)

## 1.7 Reiniciar

Ahora que hemos terminado con el servidor, hay que reiniciar el servicio para
que se lean los cambios de configuración para ello usamos estos comandos:


- systemctl stop smb, systemctl start smb, systemctl status smb

![Foto 20](20.png)

- systemctl stop nmb, systemctl start nmb, systemctl status nmb

![Foto 21](21.png)

Para comprobar que todo se ha realizado correctamente hacemos uso de estos comandos;

- sudo testparm 

![Foto 22](22.png)

- sudo netstat -tap

![Foto 23](23.png)

Antes de entrar con windows a las carpetas compartidas de samba hace falta 
añadir el servicio samba en el contafuegos para que nos permita el acceso desde windows

![Foto 24](24.png)

# 2 Windows

## 2.1 Cliente Windows

Desde un cliente Windows trataremos de acceder a los recursos compartidos del servidor Samba.

![Foto 25](25.png)

Comprobaremos los accesos de todas las formas posibles. Como si fuéramos un
sith, un jedi y/o un invitado.

Después de cada conexión se quedan guardada la información en el cliente Windows
con el comando "net use" y para cerrar las conexión SMB/CIFS que ha realizado 
el cliente al servidor, usamos el comando "net use * /d /y".

![Foto 26](26.png)

![Foto 27](27.png)

## 2.2 Cliente Windows comandos

Antes de entrar al servicio de samba primero deberemos de cerrar el servicio desde
el cliente con el comando "net use * /d /y". Ahora desde una power shell usaremos 
el comando "net use /?" para consultar la ayuda y despues usaremos el comando net view.

Empezaremos con la conexión para ello es necesario ejecutar este comando.

-  P: \\172.18.19.53\tatooine  /USER:sith1

![Foto 29](29.png)

# 3 Cliente GNU/Linux

## 3.1 Cliente GNU/Linux

Desde el entorno gráfico vamos a acceder a los recursos del servidor de samba
y para ello ponemos:

- smb://172.18.19.53

Vamos a probar a crear carpetas en corusant y en tatooine.

![Foto 31](31.png)

![Foto 32a](32a.png)

![Foto 32b](32b.png)

Tambien comprobaremos que el recurso public es de sólo lectura.
   
![Foto 33](33.png)

Por último comprobaremos resultados, desde el servidor Samba ejecutamos: smbstatus, netstat -ntap

![Foto 34](34.png)

![Foto 35](35.png)

## 3.2 Cliente GNU/Linux Comandos

A continuación vamos a nuestro cliente Samba.Desde este equipo usaremos 
comandos para acceder a la carpeta compartida.

Primero comprobaremos el uso de la siguiente herramienta:

smbclient --list ip-servidor-samba

![Foto 36](36.png)

Ahora crearemos en local la carpeta /mnt/samba-remoto/corusant.

![Foto 37](37.png)

Con el usuario root, usamos el siguiente comando para montar un recurso compartido 
de Samba Server, como si fuera una carpeta más de nuestro sistema:

-  mount -t cifs //172.18.19.53/corusant /mnt/samba-remoto/corusant -o username=sith1

Para comprobar los resultados, desde el servidor Samba ejecutamos: smbstatus y netstat -ntap.

![Foto 38](38.png)
