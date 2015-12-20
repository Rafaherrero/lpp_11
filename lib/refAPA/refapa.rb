require 'refBiblio/referencia'

module RefAPA
    class Refapa
        include Enumerable
		def initialize()
			@lista = Doublylinkedlist::Doublylinkedlist.new
		end
		def insertar(ref)
			@lista.insertar_final(ref)
			@lista.ordenar!
		end
		def each
			@lista.each{ |i| yield i}
		end
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