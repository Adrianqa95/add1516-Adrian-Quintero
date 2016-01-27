#!/usr/bin/ruby
#esconding: utp-8
#Gregorio Adrian Quintero Alvarez

#esto lo usamos para ver que usuario somos

require 'rainbow'

def soy_root

whoami =`whoami`
puts whoami

usuario= whoami.chop
#Si el comando se cumple mostrara los siguiente
	if usuario =="root"
	  puts Rainbow("Hola superusuario").color(:Green)
	#si no se cumple lo anterior pasara al siguiente apartadp
	else
	  puts Rainbow("Permiso denegado, no eres SuperUsuario").color(:Red)
	end
end 

comprobar soy_root


#buscamos el ficher de los usuarios con los datos y para ejecutamos pornemos los siguiente
users =`cat userlist.txt` # cat lo usamos para que compruebe lo que hay dentro del archivo txt
userlist = users.split ("\n")
# usamos el ("\n") para bajar de linea para que no salga todo pegado

userlist.each do |fila|
#este comando es para busque todo lo que esta dentro del contenido userlist y te lo muestre en filas
        campo = fila.split(":")
#ahora nos mostrara el contenido separado por puntos
#A continuacion llamaremos a los campos 
#Para que nos muestre el nombre de los usuarios se ha usado el #{campo[0]} se señala la primera posicion donde se encuentra el nombre del usuario

        if campo[2] == ''
#si dentro de las comillas no ahi nada escrito o es distinto mostrara un mensaje de error
                puts "El usuario #{campo[0]} #{campo[1]} tiene un email erroneo o no tiene."
        else
#ahora usaremos esto para crear un nuevo usuario ya que los usuarios que crearemos tendran
#en el lugar 4 que es el campo el add

                if campo[4]=='add'
                        `adduser #{campo[0]} --force-badname --disabled-password`
                        puts "Se ha creado el usuario #{campo[0]}"
                end
#ahora eliminaremos los usuarios que en el campo 4 tengan delete
                if campo[4]=='delete'
                        `deluser #{campo[0]} --remove-home`
                        puts "Se ha eliminado el usuario #{campo[0]}"
                end
        end
end
