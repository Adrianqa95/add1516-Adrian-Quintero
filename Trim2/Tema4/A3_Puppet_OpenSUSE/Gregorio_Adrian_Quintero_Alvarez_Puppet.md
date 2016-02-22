Gregorio Adrian Quintero Alvarez

# 1.Introducción.

En esta práctica vamos a realizar una conexión de un Master que tendrá un S.O 
de OpenSUSE y de dos clientes, uno Linux y otro Windows. Esto se realizará mediante
Puppet una herramienta diseñada para administrar la configuración de sisteras Unix-like y de Microsoft.

## 1.1 Configuración.

### Mv1 -> Master.


Esta máquina tendrá la siguiente configuración: 

 -  Sistema Operativo GNU/Linux OpenSUSE 13.2.
 -  Una  IP estática 172.18.19.100.
 -  Enlace: 172.18.0.1.
 -  DNS: 8.8.4.4.
 -  Nombre del equipo: master19.
 -  Dominio = Quintero19.
 -  Instalar OpenSSH-Server para acceso del profesor.

![Foto 1](./Master/1.png) 

![Foto 2](./Master/2.png) 

![Foto 3](./Master/3.png)

### Mv2 -> Cliente1 

Esta máquina recibirá ordenes del master y tendrá esta configuración:

 -  Sistema Operativo GNU/Linux OpenSUSE 13.2.
 -  Una IP estática 172.18.19.101.
 -  Enlace: 172.18.0.1.
 -  DNS: 8.8.4.4.
 -  Nombre del equipo: cli1alu19.
 -  Dominio = Quintero19.
 -  Instalar OpenSSH-Server para acceso del profesor.

![Foto 1](./cli1/1.png)

![Foto 2](./cli1/2.png)

![Foto 3](./cli1/3.png)

### Mv3 -> Cliente2

Esta máquina también recibirá ordenes del master y tendrá la siguiente configuración:

 -  SIstema Operativo Windows 7.
 -  Una IP estática 172.18.19.102
 -  Enlace: 172.18.0.1
 -  DNS: 8.8.4.4.
 -  Nombre Netbios: cli2alu19.
 -  Nombre del equipo: cli2alu19.
 -  Grupo de trabajo = AULA108.
 -  Instalar ServidorSSH para acceso del profesor.

![Foto 1](./cli2/1.png)

![Foto 2](./cli2/2.png)

Cada MV deberá tener configurado su fichero "/etc/hosts" para poder hacer ping
usando los nombres de las máquinas.

 #### Master

![Foto 4](./Master/4.png)

 #### Cliente1

![Foto 4](./cli1/4.png)

 #### Cliente2

![Foto 3](./cli2/3.png)

## 1.2 Comprobación de las cofiguraciones.

Para realizar la comprobación en las máquinas de OpenSUSE usaremos estos comandos:

 -  date
 -  ip a
 -  route -n
 -  host www.google.es
 -  hostname -a
 -  hostname -f
 -  hostname -d

#### Master

![Foto 5](./Master/5.png)

#### Cliente1

![Foto 5](./cli1/5.png)

 -  ping master19
 -  ping master19.Quintero19

![Foto 6](./Master/6.png)

 -  ping cli1alu19
 -  ping cli1alu19.Quintero19

![Foto 7](./Master/7.png)

 -  ping cli2alu19

![Foto 8](./Master/8.png)
  
Para realizar la comprobación en la máquina de Windows usaremos estos comandos

 -  date
 -  ipconfig
 -  route /PRINT

![Foto 4](./cli2/4.png)

 -  nslookup www.google.es

![Foto 5](./cli2/5.png)

 -  ping master19
 -  ping master19.Quintero19
 -  ping cli1alu19
 -  ping cli1alu19.Quintero19
 -  ping cli2alu19

![Foto 6](./cli2/6.png)

#IMPORTANTE

Deberemos comprobar que todas las máquinas tienen la fecha y hora correcta.

## 2. Primera versión del fichero pp.

Instalamos en el Master el PuppetMaster con este comando:

 - zypper install puppet-server puppet puppet-vim.

![Foto 9](./Master/9.png)

Consultamos el estado del servicio:

 - Systemctl status puppetmaster

Permitimos que el servicio se inicie de forma automática en el inicio de la máquina.

 - Systemctl enable puppetmaster

Ahora iniciamos el servicio y volvemos a comprobar el estado.

 - Systemctl start puppetmaster

 - Systemctl status puppetmaster

![Foto 10](./Master/10.png)

Después creamos los Ficheros//Directorios en el  Master:

 -  mkdir /etc/puppet/files
 -  mkdir /etc/puppet/manifests
 -  mkdir /etc/puppet/manifests/classes
 -  touch /etc/puppet/files/readme.txt
 -  touch /etc/puppet/manifests/site.pp
 -  touch /etc/puppet/manifests/classes/hostlinux1.pp

![Foto 11](./Master/11.png)

## 2.1 /etc/puppet/files/readme.txt.

En el interior del readme estableceremos este texto:

"¡Qué la fuerza te acompañe!."

![Foto 12](./Master/12.png)

Los ficheros que se guarden dentro del /etc/puppet/files se pueden descargar por
el resto de máquinas puppet.

## 2.2 /etc/puppet/manifests/site.pp

"/etc/puppet/manifests/site.pp" es el fichero principal de configuración de 
órdenes para los agentes/nodos puppet.

En el interior de este fichero estableceremos este contenido:

![Foto 13](./Master/13.png)

## 2.3 /etc/puppet/manifests/classes/hostlinux1.pp

Como es posible tener muchas configuraciones, se van a separar en distintos 
ficheros para organizarnos mejor y las guardaremos en /etc/puppet/manifests/classes.

Vamos a crear la primera configuración, la cual se llamará hostlinux1.pp y que tendrá
este contenido:

![Foto 14](./Master/14.png)

Ahora comprobaremos que tenemos los permisos adecuados en la ruta /var/lib/puppet.

Reiniciamos el servicio con el comando: "systemctl restart puppetmaster".

Después comprobamos que el servicio está en ejecución de forma correcta con:
 
 -   systemctl status puppetmaster

![Foto 15](./Master/15.png)

 -   netstat -ntap

![Foto 16](./Master/16.png)

A continuación consultamos los  log por si hay errores: tail /var/log/puppet/*.log

3. Instalación y Configuración 

Ahora en la máquina cliente1 instalamos el Agente Puppet mediante comando.

 - zypper in puppet.

![Foto 6](./cli1/6.png)

El cliente puppet debe ser informado de quien será su master. Para ello, añadimos a /etc/puppet/puppet.conf:

    [main]
    server=Master19.Quintero19

![Foto 7](./cli1/7.png)

 -  Comprobamos que tenemos los permisos adecuados en la ruta /var/lib/puppet.

![Foto 8](./cli1/8.png)

 -  Vemos el estado del servicio puppet.

      systemctl status puppet	

 -  Activamos el servicio en cada reinicio de la máquina.

      systemctl enable puppet

 -  Iniciamos el servicio puppet.

      systemctl start puppet

 -  Vemos el estado del servicio puppet.

      systemctl status puppet

![Foto 9](./cli1/9.png)

 -  Muestra los servicios conectados a cada puerto.

      netstat -ntap

 -  Comprobamos los log del cliente: tail /var/log/puppet/puppet.log

![Foto 10](./cli1/10png)

## 4. Certificados

### 4.1 Aceptar certificados.

Vamos al master y consultamos las peticiones pendientes de union al master: puppet cert list.

![Foto 17](./Master/17.png)

Aceptamos al nuevo cliente desde el master con: "puppet cert sign "cli1alu19.Quintero19"".

![Foto 18](./Master/18.png)

![Foto 19](./Master/19.png)

### 4.2 Comprobación Final

Nos vamos al cliente1 y reinicimos el servicio puppet.

![Foto 13](./cli1/13.png)

Comprobamos que los cambios configurados en puppet se han realizado.

![Foto 11](./cli1/11.png)

Para ver en detalle los errores, podemos reiniciar el servicio puppet en el cliente y consultar el archivo log del cliente.

Puede ser que tengamos en algún mensaje de error de configuración del fichero /etc/puppet/manifests/site.pp
del master, si es asi ir al master y corregir los errores y continuar con el siguiente paso.

## 5 Segunda versión del fichero pp

A continuación probaremos una configuración mas compleja del puppetmaster.

Esto irá en otro fichero pp que se llamara hostlinux2.pp, el cual tendrá este contenido:

![Foto 20](./Master/20.png)

También deberemos configurar el fichero site.pp para añadir el hostlinux2.pp

![Foto 21](./Master/21.png)

## 6. Cliente puppet Windows

Ahora vamos a configurar puppet para atender también a clientes de Windows

### 6.1 Modificaciones en el Master 

En el master vamos a crear una configuración puppet para las máquinas windows,
dentro del fichero etc/puppet/manifests/classes/hostwindows3.pp, con el siguiente contenido:

![Foto 22](./Master/22.png)

Ahora vamos a modificar el fichero site.pp del master, para que tenga en cuenta
la configuración de clientes GNU/Linux y clientes Windows, de la siguiente forma:

![Foto 23](./Master/23.png)

Después reiniciamos el servicio PuppetMaster y comprobamos que versión tenemos 
instalada con el comando "Facter" puesto que en la máquina Windows hace falta tener
instalada la misma versión que el master.

![Foto 24](./Master/24.png)

![Foto 25](./Master/25.png)

### 6.2 Modificaciones en el Cliente2

Vamos a instalar el AgentePuppet en windows, despues de haberla instalado reinicimos la
máquina y aceptamos el certificado en el master para este nuevo cliente.

![Foto 8](./cli2/8.png)

![Foto 10](./cli2/10.png)

Ahora aceptamos el certificado en el master

![Foto 11](./cli2/11.png)

![Foto 12](./cli2/12.png)

![Foto 13](./cli2/13.png)

Iniciamos el puppet como administrador y probamos los siguientes comandos:

 -  puppet agent --configprint server, debe mostrar el nombre del servidor puppet. En nuestro ejemplo debe ser Master19.Quintero19.
 -  puppet agent --server Master19.Quintero19 --test: Comprobar el estado del agente puppet.

![Foto 14](./cli2/14.png) 

-  puppet agent -t --debug --verbose: Comprobar el estado del agente puppet.
 -  facter: Para consultar datos de la máquina windows

![Foto 15](./cli2/15.png)

 -  puppet resource user Adrian: Para ver la configuración puppet del usuario.

![Foto 16](./cli2/16.png)

 -  puppet resource file c:\Users: Para var la configuración puppet de la carpeta.

![Foto 17](./cli2/17.png)

Ahora vamos a la configuración del master y creamos el fichero "hostwindows3.pp" en
la ruta "/etc/puppet/manifests/classes" con este contenido:

class hostwindows3 {
  user { 'darth-sidius':
    ensure => 'present',
    groups => ['Administradores']
  }

  user { 'darth-maul':
    ensure => 'present',
    groups => ['Usuarios']
  }
}

Tambien debemos añadir el en el site.pp el hostwindows3.pp

![Foto 23](./Master/23.png)



