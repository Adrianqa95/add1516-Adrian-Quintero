#!/usr/bin/ruby
#esconding: utp-8

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

  puts lista #realizaremos este puts para que nos muestre la lista de programas

if action == "remove" or action == "r"  # Si la action es igual a remove nos realizara la desinstalacion de geany
        `apt-get remove geany`

end