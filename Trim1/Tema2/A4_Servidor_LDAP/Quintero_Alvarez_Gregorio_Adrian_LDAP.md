Gregorio Adrián Quintero Álvarez

#Servidor LDAP - OpenSUSE

## 1.1 Preparar la máquina

Comenzamos la instalación del servidor LDAP para ello vamos a usar una MV para montar nuestro servidor LDAP con un sistema operativo OpenSUSE 13.2
con una IP estática la cual será 172.18.19.51, y el nombre de equipo "ldap-server-19" y de dominio "curso1516"

![Foto 1](./imagenes/1.png)

![Foto 2](./imagenes/2.png)

Después en el archivo /etc/hosts añadiremos

- 127.0.0.2   ldap-server-19.curso1516   ldap-server-19
- 127.0.0.3   adrian19.curso1516  adrian19

![Foto 6](./imagenes/6.png)


Por último realizaremos los siguientes comandos: ip a, hostname -f, lsblk, blkid

![Foto 18](./imagenes/18.png)

##1.2 Instalación del Servidor LDAP

Procedemos a la instalación del módulo Yast para gestionar el servidor LDAP (yast2-auth-server) y apartir de aquí seguimos los pasos indicados en servidor LDAP de la siguiente forma:

![Foto 5](./imagenes/5.png)

Iremos a yast y buscaremos el Servidor de autenticación. y seleccionamos estas opciones:

![Foto 9](./imagenes/9.png)

- Elegimos como tipo de servidor: autónomo

![Foto 10](./imagenes/10.png)

- En la configuración TLS la dejamos en NO habilitar

![Foto 13](./imagenes/13.png)

- Usamos como DN lo siguiente: dc=adrian19, dc=curso1516.
- Como contraseña se estableció "alumno"

![Foto 11](./imagenes/11.png)

- NO habilitamos kerberos.

![Foto 12](./imagenes/12.png)

Una vez instalado, comprobamos el servicio con el comando "systemctl status slapd" y miramos que el servicio se inicia automáticamente al reiniciar la máquina.

![Foto 16](./imagenes/16.png)

![Foto 17](./imagenes/17.png)

Continuamos instalando el GQ mediante comando y despues comprobar el contenido de la base de datos LDAP usando la herramienta gq.

![Foto 21](./imagenes/21.png)

![Foto 22](./imagenes/22.png)

## 1.3. Crear usuarios y grupos en LDAP

Ahora vamos a introducir datos de usuarios y grupos en el servidor LDAP personalizando la información de la siguiente forma:

Debemos instalar el paquete yast2-auth-client, que nos ayudará a configurar la máquina para autenticación. En Yast aparecerá como Authentication Client.

![Foto 5](./imagenes/5.png)

El parámetro LDAP URI es un localizador del recurso de la base de datos LDAP -> ldap://dc=adrian19,dc=curso1516

![Foto 20](./imagenes/20.png)

Las unidades organizativas: groups y people. Han sido creadas automáticamente por Yast en el paso anterior.

Crear los grupos jedis2 y siths2 (Estos se crearán dentro de la ou=groups).

![Foto 15](./imagenes/15.png)

Crear los usuarios jedi21, jedi22, sith21, sith22 (Estos se crearán dentro de la ou=people).

![Foto 14](./imagenes/14.png)

Ahora comprobamos que los usuarios creados anteriormente estan dentro de los grupos que se encuentran el el GQ.

![Foto 23](./imagenes/23.png)

Despues con el comando ldapsearch -x -L -u -t "(uid=nombre-del-usuario)" se puede consultar la base de datos de LDAP y ver la información de los
usuarios e aquí un ejemple:

 ![Foto 24](./imagenes/24.png)

## 1.4 Autentificación

Desde el servidor LDAP vamos a comprobar el acceso con los usuarios definidos en LDAP.

A continuación usamos los siguientes comandos para ver la información en el sistema.
(hostname -f, ip a, date, cat /etc/passwd | grep "Nombre del usuario", finger "Nombre del usuario", id "Nombre del usuario", su "Nombre del usuario" )

 ![Foto 25](./imagenes/25.png)

 ![Foto 26](./imagenes/26.png)

# 2 Otro equipo

## 2.1 Preparativo

Al otro equipo le estableceremos una IP estatica la cual será 172.18.19.52, como nombre del equipo usaremos "ldap-slave-19" y de dominio "curso1516".
Después iremos al archivo /etc/hosts añadiendole los datos del servidor ldap para realizar la conexión.

![Foto 3](./imagenes/3.png)

![Foto 4](./imagenes/4.png)

Por ultimo realizaremos los siguientes comandos: ip a, hostname -f, lsblk, blkid

![Foto 27](./imagenes/27.png)



## 2.2 Configuración

Siguiendo las instrucciones vamos a crear el grupo LDAP troopers y dentro de este trooper1 y trooper2 y despues con el gq comprobamos los datos del servidor LDAP
