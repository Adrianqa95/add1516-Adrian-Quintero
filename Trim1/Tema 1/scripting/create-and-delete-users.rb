#!/usr/bin/ruby
#enconding: utf-8
 
 
if [ $(whoami) != "root" ]; then
    echo "Tienes que ser root para ejecutar este script"
    echo "Ejecuta "sudo su" para ser root"
exit 1
