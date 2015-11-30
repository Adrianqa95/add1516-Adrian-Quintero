Gregorio AdriÁn Quintero Álvarez

#Acceso Remoto de SHH

## 0.1 Introducción

En esta práctica lo que vamos a realizar es una conexión remota mediante shh y
para ello es necesario la instalación del servicio shh y estas tres máquinas:
- Un servidor OpenSUSE con una ip estatica la cual será 172.18.19.53.
- Un cliente OpenSUSE con un ip estatica la cual será 172.18.19.54.
- Un cliente Windows 7 con ip estatica y que será 172.18.19.13.

## 0.2 Configuración de red

Ahora nos dispondremos a realizar la configuración de las redes de las máquinas
estableciendolas es estático y para realizar esta modificación usaremos el entorno
gráfico que nos proporciona OpenSUSe que es yast.

![Foto 1](1.png)

![Foto 2](2.png)

![Foto 3](3.png)

Tambien vamos a realizar dicha configuración en windows 7.

![Foto 3b](3b.png)

# 1 Preparativos

## 1.1 Servidor SSH

Vamos a empezar configurando la máquina de OpenSUSE estableciendole los siguiente
valores:
- Como nombre de usuario pondremos nuestro nombre
- Como clave para root usaremos nuestro DNi
- Para nombre del equipo usaremos ssh-server
- Como nombre del dominio estableceremos el segundo apellido

Ahora iremos a la la extensión /etc/ y editaremos el archivo hosts y le añadiremos
los datos del cliente y de windows, ambos los configuraremos a continuación.

![Foto 5a](5a.png)

Después para comprobar que los cambios se han realizado ejecutarmos una serie de
comandos, los cuales son los que vemos en la imagen que se muestra a continuación:

![Foto 6](6.png)

Ahora crearemos 4 usuarios a los cuales le pondremos de nombre el primer apellido
y le añadiremos un número del 1-4.

![Foto 7](7.png)

## 1.2 Cliente OpenSUSE

En el cliente de OpenSUSE estableceremos como nombre de usuario nuestro nombre,
como contraseña de root nuestro DNi y como nombre del equipo ssh-client1 y le 
pondremos el mismo dominio que al servidor nuestro segundo apellido, después 
modificaremos el archivo /etc/hosts y le añadiremos el servidor y el cliente de windows.

![Foto 5b](5b.png)

## 1.3 Cliente Wondows 7

En esta máquina instalaremos el cliente ssh para ello descargaremos un programa
llamado PuTTY y lo ejecutamos.

![Foto 10](10.png)

Despues configuraremos el windows estableciendo como nombre de usuario nuestro nombre
y como clave de administrador nuestro DNi, también le cambiaremos el nombre del
equipo y ponemos ssh-client2-19 y por último modificaremos el archivo hosts
situado en C:\Windows\System32\drivers\etc\ y le añadiremos el equipo 
ssh-server y ssh-client1.

![Foto 6b](6b.png) 

# 2 Instalación del servicio SSH

Estando en nuestro servidor iremos a un terminal y ejecutaremos el comando zypper in openssh
el cual nos instalara el servicio ssh si no lo tenemos instalado, en cambio si el servicio ya se encuentra en nuestro equipo nos dira que ya esta 
instalado y nos dira que versión tenemos.

![Foto 8](8.png)

## 2.1 Comprobación 

Desde nuestro servidor ejecutaremos el comando "systemctl status sshd" para ver en que estado se encuentra nuestro servicio el cual aparece desabilitado y sin ejecutar

![Foto 9](9.png)
 
para cambiar eso ejecutaremos estos dos comandos:

- systemctl enable sshd para pones en servicio en enable 
- systemctl start sshd para poner en ejecución el servicio shh

Despues comprobaremos que nuestro servicio esta escuchando por el puesto 22 usando el comando "netstat -ntap"

![Foto 11](11.png)

## 2.2 Primera conexión SSH desde el cliente

Empezaremos comprobando que desde nuestro cliente hay conexión con nuestro servidor para ello 
haremos un ping al ssh-server y después comprobaremos que el servidor tiene el puerto 22 abirto 
usando el comando nmap ssh-server desde el cliente.

Puesto que nuestra conexión fallo la primera vez nos vamos al cortafuegos y en
servicios autorizados pondremos el SSH en una zona externa.

![Foto 15](15.png)

asi nos permita la conexión entre ambos y tambien configuraremos la interfaces.

![Foto 14](14.png)

Después realizaremos el ping ssh-server y  nmap ssh-serve y comprobamos que nos sale la escucha del puerto 22.

![Foto 12](12.png)

Ahora desde el cliente nos vamos a conectar al usuario quintero1 que se encuentra en el servidor
para ello pondremos ssh quintero1@ssh-server.Alvarez. Durante esta conexión se intercambiaran las claves
que se producen en la primera conexión SSH.

![Foto 16](16.png)

A continuación saldremos y nos volveremos a conectar y vemos que ahora no nos sale el intercambio de claves
solo nos pide nuestra contraseña y se realiza la conexión.

![Foto 17](17.png)

Ahora cerraremos la conexión entre ambos y desde nuestro cliente comprobaremos el archivo 
known_hosts que se encuentra en nuestro home para ello usamos el comando ll .ssh/ 

![Foto 18](18.png)

Una vez llegado a este punto probamos la conexion con windows puesto que la configuración
esta realizada correctamente tambien nos debería dejar entrar sin problemas.

![Foto 18b](18b.png)

## 2.3 Cambiar la clave en el servidor

Lo que vamos a realizar primero sera que existen los ficheros en /etc/ssh para ello
usaremos el comando "ll" desde el servidor

![Foto 19](19.png)

Después modificaremos la configuracion de ssh (/etc/ssh/shhd_config) para dejar una linea
que definirá las claves que van a identificar nuestro servidor.

![Foto 20](20.png)

Mediante otro comando generaremos las nuevas claves de SSH para ello es necesario ser root

![Foto 21](21.png)

Ahora reiniciamos el servicio SSH para que los cambios se aplique y lo comprobamos

![Foto 22](22.png)

Para comprobar que el cambio se ha realizado intentamos entrar con los usuarios de quintero1 y quintero2
desde los dos clientes tanto desde client1 como de client2.

-Client1

![Foto 23](23.png)

-Client2 

![Foto 24](24.png)

Para restablecer la entrada de usuarios y que no nos de problemas usamos el comando
que no pedia y asi restablecer las nues claves del servidor en el cliente.

![Foto 25](25.png)

# 3 Personalización del prompt Bash

A continuación vamos a realizar la configuracion del .bashrc para que la apariencia 
cuando entremos en los clientes cambie y aparezca de otra forma. Para ello vamos 
a ir al home del usuario que queremos personalizar y configuramos el .bashrc. Ademas
tambien crearemos el archivo .alias con accesos rapidos

![Foto 26](26.png)

![Foto 26b](26b.png)

# 4 Autenticacion mediante claves públicas

En este apartado vamos a configurar SSH para poder acceder desde el cliente1,
usando quintero4 sin poner password

Vamos a configurar la autenticación mediante clave pública para acceder con nuestro
usuario personal desde el equipo cliente al servidor con el usuario 1er-apellido-alumno4.

- Iniciamos sesión con nuestro usuario nombre-alumno de la máquina ssh-client1.

![Foto 27](27.png)

- Ejecutamos ssh-keygen -t rsa para generar un nuevo par de claves para el usuario en /home/nuestro-usuario/.ssh/id_rsa y /home/nuestro-usuario/.ssh/id_rsa.pub.

![Foto 28](28.png)

- Ahora vamos a copiar la clave pública (id_rsa.pub) del usuario (nombre-de-alumno)de la máquina cliente, al fichero "authorized_keys" del usuario remoteuser4 en el servidor. Hay dos formas de hacerlo:
Modo 1. Usando un comando específico para ello ssh-copy-id remoteuser4@ssh-server

![Foto 29](29.png)

- Comprobar que ahora podremos acceder remotamente, sin escribir el password desde el cliente1.

![Foto 30](30.png)

- Comprobar que al acceder desde cliente2, si nos pide el password.

![Foto 31](31.png)

# 5 Uso de SSh como túnel para X

Desde nuestro servidor instalamos una aplicación de entorno gráfico como el geany,
en el caso de que esta aplicación estuviese instalada en los clientes tendriamos que quitarlas.

![Foto 32](32.png)

Posteriormente modificaremos el servidor ssh para que permita la ejecución de aplicaciones
gráficas desde los clientes

![Foto 33](33.png)

Ahora comprobaremos que desde nuestro cliente nos permite utilizarlo para ello hay que
entrar de forma remota para ello usamos ssh -X quintero1@ssh-server.alvarez

![Foto 34](34.png)

# 6 Aplicaciones Windows nativas

Usando un emulador en el servidor podemos acceder desde OpenSUSE a aplicaciones de 
windows.

Para ello instalamos el emulador Wine

![Foto 35](35.png)

Después podremos usar la aplicación notepad que se instala por defecto al instalar el Wine y
para ver que esto funciona ponemos en el servidor notepad

![Foto 36](36.png)

Ahora hacemos la misma comprobación desde client1 para ello es necesario entrar de forma remota

![Foto 37](37.png)

# 7 Restricciones de uso

## 7.1 Sin Restricción

Al usuario 1 no se le aplicaran restricciones podra acceder libremente

## 7.2 Restricción total

En el servidor SSH le aplicaremos la restricción al usuario2  para que no tenga acceso
mientra que los demas podrán acceder libremente.

Para ello configuramos el /etc/ssh/shhd_config estableciento unas lineas al final

![Foto 38](38.png)

Ahora comprobaremos el acceso desde ambos clientes

- Client1 

![Foto 39](39.png)

- Client2

![Foto40](40.png)

## 7.4 Restricciones sobre aplicaciones

Ahora vamos a crear una restricción de permisos sobre determinadas aplicaciones.

- Usaremos el usuario remoteuser4
- Crear grupo remoteapps
- Incluir al usuario en el grupo.

![Foto 41](41.png)

- Localizar el programa APP1. Posiblemente tenga permisos 755.
- Poner al programa APP1 el grupo propietario a remoteapps

![Foto 42](42.png)

- Poner los permisos del ejecutable de APP1 a 750. Para impedir que los que no pertenezcan al grupo puedan ejecutar el programa.

![Foto 44](44.png)

- Comprobamos el funcionamiento en el servidor.

![Foto 45](45.png)

- Comprobamos el funcionamiento desde el cliente.

![Foto 46](46.png)
