Gregorio Adrian Quintero Alvarez

#Cliente ligero con LTPS

## Preparativos

Para realizar esta practica hemos tenido que utilizar dos maquinas virtuales
con un sistema operativo de ubuntu. Una de ellas la vamos a usar como servidor
y la otra la crearemos como cliente, esta maquina no tendrá ni disco duro ni 
disco de CD.

## Preparar el Ubuntu Server

Con esta maquina empezaremos estableciendo en los ajustes de virtualbox el 
adaptador de red en adaptador puente para una ip estatica para la conexion a
internet de la propia maquina y  un segundo adaptador de red en red interna
para ponerle una interfaz estatica que usaremos de conexion para el cliente 
con una ip que debe estar en la misma red que los clientes (192.168.0.1)

![foto 3](3.png)

## Configuracion del SSOO

En nuestra maquina de ubuntu server estableceremso como nombre de usuario 
nuestro nombre y como contraseña root nuestro DNI despues pondremos nuestro 
primer apellido como nombre del equipo y de nombre del dominio el segundo apellido
despues ejecutamos unos comandos para ver que todo se ha cambiado:

![Foto 1](1.png)

![Foto 2](2.png)

![Foto 4a](4a.png)

![Foto 4b](4b.png)

![Foto 4c](4c.png)

Despues creamos tres usuarios llamado quintero alvarez y gregorio y entramos 
para definir el escritorio, estos usuarios los usaremos mas tarde con el cliente
de ubuntu.

![Foto 5](5.png)

## Instalar el servicio LTSP

En este apartado procederemos a la instalacion del LTSP en ubuntu para crear la 
imagen SO para conectar los clientes para ello hacemos uso del comando apt-get
install openssh-server, despues instalamos el servidor de clientes lijeros con 
el comando apt-get install ltsp-server- standalone y a continuacion creamos la
imagen del SO con el comando ltsp-build-cliente, este procesor llevara su tiempo
por lo cual esperaremos a que la imagen este lista.

![Foto 8](8.png)

![Foto 6](6.png)

![Foto 7](7.png)

## Preparando el Cliente

Para hacer de cliente tenemos que crear una maquina virtual vacia, esto es, sin
disco duro y sin unidad de DVD, solo contiene la RAM y el Flopy ademas de eso la
tarjeta de red PXE tiene que estar en red interna para que funcione perfectamente.
Con el servidor de ubuntu que tiene la imagen SO encendido encenderemos el cliente 
pulsaremos F12 y porteriormente la "l" para seleccionar flopy de esta manera la
maquina cliente se conectara y nos aparecera la pantalla de ubuntu pidiendo un
usuario, entraremos con uno de los creados y despues sacamos capturas de unos
comando. Ademas grabaremos un video con la maquina funcionando. El link del
se encontrara al final de este archivo

![Foto 10](10.png)

![Foto 11](11.png)

![Foto 12](12.png)

Link del video: https://youtu.be/I4kJEeICAJE
