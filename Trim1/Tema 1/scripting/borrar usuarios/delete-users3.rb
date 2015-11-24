#!/usr/bin/ruby
#esconding: utp-8

#localizar nombre de fichero
#comando $ls userlist*
comando = "ls userlist*"
filename = comando.split("\n")
puts filename.to_s

if
	array vacio then
	puts "No hay archivos userslist* para cargar"
	salir del programa
end 

# cargar los usuariosdesde fichero

puts "//------------------"
puts "voy a eliminar los usuarios de #{filesname[0]}"
users ="cat #{filename[0]}"
userslist= users.split("\n")

#borrar los usuarios
userlist.earch do |usu|
	puts "userdel -f -r #{usu}"
end 
