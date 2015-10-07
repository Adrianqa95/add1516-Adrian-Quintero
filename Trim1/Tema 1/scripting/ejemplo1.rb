#!/usr/bin/ruby
system('mkdir curso1516')
asignaturas=['add','srd','ade','sgy']
	asignaturas.each do |Nombre|
		puts 'mkdir curso1516#{Nombre}'
	puts 'Se a creado la carpeta'+Nombre
end
