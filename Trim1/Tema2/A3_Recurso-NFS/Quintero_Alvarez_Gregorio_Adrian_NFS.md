Gregorio Adrian Quintero Alvarez

#NFS (Network File System)

NFS es una forma de crear recursos en red para compartir con sistemas heterogéneos.

## 1. SO Windows

Para la parte de windows vamos a necesitar 2 máquinas:

Una máquina virtual de  Windows 2008 Server como servidor NFS.

- Como nombre de la máquina usaremos nuestro primer apellido+19+WS", le pondremos una IP estática 172.18.19.22  y como grupo de trabajo AULA108.

![Foto 1](./Nfs-windows/1.png)    

![Foto 2](./Nfs-windows/2.png)

Una máquina virtual de Windows 7 (Enterprise) como cliente NFS.
       
- Como nombre de la máquina usaremos nuestro primer apellido+19+WC", le pondremos una IP estática 172.18.19.12  y como grupo de trabajo AULA108.

![Foto 3](./Nfs-windows/3.png)

![Foto 4](./Nfs-windows/4.png)

## 1.1 Servidor NFS Windows

Empezaremos con la Instalación del servicio NFS en Windows 2008 Server

- Iremos a la parte de agregar rol Servidor de Archivos y marcamos Servicio para NFS.

![Foto 5](./Nfs-windows/5.png)

![Foto 5](./Nfs-windows/6.png)

Ahora configuraremos el servidor NFS de la siguiente forma:

A continuacion crearemos la carpeta c:\export\public y  la configuramos para 
que sea accesible desde la red en modo lectura/escritura con NFS.

![Foto 8](./Nfs-windows/8.png)

![Foto 9](./Nfs-windows/9.png)

Después crearemos la carpeta c:\export\private y la configuramos para quea 
accesible desde la red sólo en modo sólo lectura.

![Foto 8](./Nfs-windows/8.png)

![Foto 10](./Nfs-windows/10.png)

Para comporbar  los recursos compartidos usamos el comando showmount -e 172.18.19.22.

![Foto 11](./Nfs-windows/11.png)

## 1.2 Cliente NFS

Vamos a instalar el soporte cliente NFS bajo Windows 7

En primer lugar vamos a instalar el componente cliente NFS para Windows. Para ello vamos a Panel de Control -> Programas -> 
Activar o desactivar características de Windows.

- Nos desplazamos por el menú hasta localizar Servicios para NFS y dentro de
este, Cliente NFS, elegimos ambos y le damos a Aceptar y en unos instantes 
tendremos el soporte habilitado.

![Foto 12](./Nfs-windows/12.png)

Para iniciar el servicio NFS en el cliente, abrimos una consola con permisos de Administrador y ejecutamos el siguiente comando: 

- nfsadmin client start

![Foto 13](./Nfs-windows/13.png)

## 1.3 Montando el recurso

Ahora necesitamos montar el recurso remoto para poder trabajar con él, para 
ello es necesario seguir unos pasos, esto no lo hacemos con Administrador,
 sino con nuestro usuario normal.

- Consultar desde el cliente los recursos que ofrece el servidor: showmount -e 172.18.19.22

![Foto 14](./Nfs-windows/14.png)

- Montaremos el recurso remoto con: mount –o anon,nolock,r,casesensitive \\172.18.19.22\Nombre-recurso-NFS *

- Public

![Foto 15](./Nfs-windows/15.png)

- Private

![Foto 15](./Nfs-windows/15a.png)

- Comprobaremos en el cliente los recursos montados: net use.

![Foto 16](./Nfs-windows/16.png)

- Comprobaremos desde el cliente: showmount -a 172.18.19.22.

![Foto 17](./Nfs-windows/17.png)

- En el servidor ejecutamos el comando showmount -e 172.18.19.22, para ver los recursos compartidos.

![Foto 18](./Nfs-windows/18.png)

Si tenemos problemas comprobaremos el cortafuegos del servidora ver si permite accesos NFS.

- Para desmontar la unidad simplemente escribimos en una consola: umount z:

![Foto 19](./Nfs-windows/19.png)

- En el servidor ejecutamos el comando showmount -e 172.18.19.22, para comprobar los recursos compartidos.

![Foto 20](./Nfs-windows/20.png)

# 2 OpenSUSE

Vamos a necesitar 2 máquinas GNU/Linux:

Una máquina de OpenSUSE, donde instalamos el servicio NFS 

- Como nombre de esta máquina usar nfs-server-19. Modificaremos el fichero /etc/hostname y el fichero /etc/hosts, usaremos una IP estática 172.18.19.52
y el VirtualBox Red en Modo Puente

![Foto 1](./nfs-OpenSuse/1.PNG)

![Foto 2](./nfs-OpenSuse/2.PNG)

Una máquina de OpenSUSE, donde instalaremos el cliente NFS.
        
- Como nombre de esta máquina usar nfs-client-19, usaremos una IP estática 172.18.19.62 y pondremos el VirtualBox Red en Modo Puente

![Foto 1](./nfs-OpenSuse/1.png)

![Foto 2](./nfs-OpenSuse/2.png)

/ETC/HOSTS: Por comodidad podemos configurar el fichero /etc/hosts del cliente y servidor, añadiendo estas líneas:

-   172.18.XX.52 nfs-server-19.alvarez   nfs-server-19
-   172.18.XX.62 nfs-client-19.alvarez   nfs-client-19

- Servidor

![Foto 3](./nfs-OpenSuse/3.PNG)

- Cliente

![Foto 3](./nfs-OpenSuse/3.png)

2.1 Servidor NFS

Para instalar servidor NFS usaremos el entorno grafico de OpenSUSE denominado Yast.

![Foto 4](./nfs-OpenSuse/4.PNG)

![Foto 7](./nfs-OpenSuse/7.png)

Crearemos las siguientes carpetas y le asignaremos unos permisos:

- /var/export/public, usuario y grupo propietario nobody:nogroup

- /var/export/private, usuario y grupo propietario nobody:nogroup, permisos 770
  
![Foto 5](./nfs-OpenSuse/5.PNG)

Ahora vamos a configurar el servidor NFS de la siguiente forma:

- La carpeta /var/export/public, será accesible en modo lectura/escritura.
        
- La carpeta /var/export/private, sea accesible sólo en modo lectura.
    
Para ello usaremos el Yast o modificamos el fichero /etc/exports añadiendo las siguientes líneas:

![Foto 6](./nfs-OpenSuse/6.png)

Para iniciar y parar el servicio NFS, usaremos Yast o systemctl. Si al iniciar el servicio aparecen mensaje de error 
o advertencias, debemos resolverlas.

![Foto 11](./nfs-OpenSuse/11.png)

Para comprobarlo, showmount -e localhost. Muestra la lista de recursos exportados por el servidor NFS.

![Foto 12](./nfs-OpenSuse/12.png)

## 2.2 Cliente NFS

En esta parte, vamos a comprobar que las carpetas del servidor son accesibles 
desde el cliente. Normalmente el software cliente NFS ya viene preinstalado 
pero si tuviéramos que instalarlo en OpenSUSE zypper in nfs-common.

![Foto 4](./nfs-OpenSuse/4.png)

Antes de realizar la comprobacion de conectividad nos vamos al Servidor y modificamos
el contafuegos.

![Foto 8](./nfs-OpenSuse/8.png)

Comprobar conectividad desde cliente al servidor:

- ping 172.18.19.22: Comprobar la conectividad del cliente con el servidor. Si falla hay que revisar las configuraciones de red.

![Foto 9](./nfs-OpenSuse/9.png)

- nmap 172.18.19.22 -Pn: nmap sirve para escanear equipos remotos, y averiguar que servicios están ofreciendo al exterior.

![Foto 10](./nfs-OpenSuse/10.png)

- showmount -e 172.18.19.22: Muestra la lista de recursos exportados por el servidor NFS.

En el cliente vamos a montar y usar cada recurso compartido.

Creamos la carpeta /mnt/remoto/public y con el comando mount.nfs 172.18.19.22:/var/export/public /mnt/remoto/public montamos el recurso.

Ahora usando df -hT veremos que los recursos remotos están montados en nuestras carpetas locales.

Para montar los recursos NFS del servidor Windows haremos mount.nfs 172.18.19.22:/C/export/public /mnt/remoto/windows. Ahora podemos crear carpetas o 
ficheros dentro del recurso public, pero sólo podremos leer lo que aparezca en private.

2.3. Montaje automático

Para configurar acciones de montaje autoḿaticos cada vez que se inicie el equipo en OpenSUSE usamos Yast o bien modificamos la configuración del fichero /etc/fstab. Comprobarlo.

Incluir contenido del fichero /etc/fstab en la entrega.

