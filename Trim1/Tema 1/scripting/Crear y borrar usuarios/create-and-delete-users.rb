#!/usr/bin/ruby
#enconding: utf-8
 
 
#esto lo usamos para ver que usuario somos
whoami ="whoami"
usuario= whoami.chop

#vamos a entrar como superusuario y si no eres que nos muestre un mensaje y nos diga
#que no lo eres y te envie fuera
if usuario =="root"
	#ahora mostraria un mensaje dando la bienvenida a root
	puts "Hola superusuario"
else
#si no eres superusuario no te permite ejecutarlo
 puts "Permiso denegado, no eres SU"

end

#buscamos el ficher de los usuarios con los datos y para ejecutamos pornemos los siguiente
users ="cat userlist.txt"
# cat lo usamos para que compruebe lo que hay dentro del archivo txt
userlist = users.split ("\n")
# usamos el ("\n") para bajar de linea para que no salga todo pegado

userlist.earch do |fila|
#este comando es para busque todo lo que esta dentro del contenido userlist y te lo muestre en filas
	campo = fila.split(":")
#ahora nos mostrara el contenido separado por puntos
	if campo[2] == '' or campo[2]!=''
	#si dentro de las comillas no ahi nada escrito o es distinto mostrara un mensaje de error
		puts 'El usuario tiene un email erroneo o no tiene'
	else
#ahora usaremos esto para crear un nuevo usuario ya que los usuarios que crearemos tendran
#en el lugar 4 que es el campo el add
	
		if campo[4]=='add' "useradd -d /home/#{campo[0]} -m -s bin/bash #{campo[0]} 2> /del/null"
			puts "Se ha creado el usuario #{campo[0]}"
		end
#ahora eliminaremos los usuarios
		if campo[4]=='del' "deluser -d /home/#{campo[0]} -f -r bin/bash #{campo[0]}"
			puts "Se ha eliminado el usuario #{campo[0]}"
		end
end
