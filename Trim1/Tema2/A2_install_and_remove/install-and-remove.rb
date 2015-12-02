#!/usr/bin/ruby
#esconding: utp-8
#Gregorio Adrian Quintero Alvarez

#esto lo usamos para ver que usuario somos
whoami =`whoami`
puts whoami

usuario= whoami.chop
#Si el comando se cumple mostrara los siguiente

if usuario =="root"
  puts "Hola superusuario"

#si no se cumple lo anterior pasara al siguiente apartadp
else
  puts "Permiso denegado, no eres SuperUsuario"
end

#ahora vamos a llamar al alchivo de texto con los nombres de los programas

programas=`cat software-list.txt` # el cat se usa para comprobar el contenido del archivo txt

lista = programas.split("\n") #en este ejecutamos el el split al que llamaremos lista

lista.each do |linea|

#este comando es para busque todo lo que esta dentro del contenido lista y te lo muestre en lineas
	
	action = linea.split(":") 

#usamos action para definirlo y poderlo usar mas abajo y selecionarael contenido separado por puntos
#Para que compruebe el nombre de los paquetes se usa el #{campo[0]} que señala la primera posicion con lo siguiente 
#vamos a realizar una comprobacion del archivo a ver si se encuetra instalado
	
	comprobar = `dpkg -l #{action[0]}|grep ii`
	
		if action[1] == "remove" or action[1] == "r"  # Si la comprobacion el programa esta instalado y la action es remove o r nos realizara la desinstalacion del programa
			  `apt-get remove -y #{action[0]}`
			puts "#{action[0]} fue desinstalado correctamente"
		
		elsif action[1] == "install" or action[1] == "i" # Si la comprobacion el programa no esta instalado y la action es install o i nos realizara la desinstalacion del programa
			  `apt-get install -y #{action[0]}`
			puts "#{action[0]} fue instalado correctamente"
		end
end