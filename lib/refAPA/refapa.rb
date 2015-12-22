require 'refBiblio/referencia'

module RefAPA
# En esta clase creamos nuestra lista de referencias segun APA
# @author Rafael Herrero
    class Refapa
        include Enumerable
		def initialize()
			@lista = Doublylinkedlist::Doublylinkedlist.new
		end
# Metodo que inserta una referencia en la lista y la ordena
# @param [ref] referencia a insertar

		def insertar(ref)
			@lista.insertar_final(ref)
			@lista.ordenar!
		end
# Método para que la clase sea enumerable
# @yield [i] Cada elemento de la lista

		def each
			@lista.each{ |i| yield i}
		end
# Metodo que devuelve en un string la lista de referencias formateada
# @return un string con la lista de referencias ordenada y con formato

		def to_s
			string = ""
			@lista.each do |i|
				string << i.to_s
				string << "\n"
			end
			return string
		end
	end
end