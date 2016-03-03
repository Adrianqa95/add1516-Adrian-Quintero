#!/usr/bin/ruby
# enconding: utf-8
# Gregorio Adrian Quintero Alvarez

# Esto lo usamos para ver quienes somos
puts " "

def comprobar_usuario
	whoami=`whoami`
	puts whoami
	usuario= whoami.chop

	# Si el usuario cumple los requisitos mostrará lo siguiente.
	if usuario == "root"
	  puts "Hola superusuario"
	  #Si no cumple los requisitos anteriores pasara al siguiente apartado.
	else 
	  puts "Permiso denegado no eres un superusuario"
	end 
end
puts " "
 
def processlist
# Buscamos el fichero con el listado de procesos.
process=`cat black-list.txt` #El cat lo usaremos para que nos muestre lo que hay dentro del txt
processlist = process.split("\n") #Usaremos este comando para llamar el split.

end 

def controlar_procesos(action)


  # Usaremos el action para definirlo mas abajo y poderlo usar mas abajo y seleccionar el contenido separado por puntos
  # Para comprobar el nombre de los paquetes usamos el #{campo[0]} ya que señala la primera posicion.
  # Realizaremos una comprobación para ver que el archivo se encuentra instalado.

	  comprobar = system("ps -e| grep #{action[0]}| grep -v color")

	  # Ahora vamos a realizar el proceso de eliminacion del programa 
	  if action[1]=="kill" or action[1]=="k" or action[1]=="remove" or action[1]=="r" and comprobar==true
		system("killall #{action[0]}")
		puts "_KILL_: Proceso #{action[0]} eliminado"
		puts " "
	  elsif (action[1]=="notify" or action[1]=="n") and comprobar==true
		puts "NOTICE: Proceso #{action[0]} en ejecucion" 
		puts " "
	  elsif (action[1]=="notify" or action[1]=="n") and comprobar==false
		puts "NOTICE: Proceso #{action[0]} no esta en ejecucion"
		puts " "
	  end
	end

	comprobar_usuario
	processlist
	system ("touch state.running 1>/dev/null")
	
while File.exist? "state.running"  do
		processlist.each do |linea|
		action = linea.split(":")
		
		controlar_procesos(action)
		sleep(5)
	end
end
 

puts "Es script ya no se esta ejecutando" 
puts " "