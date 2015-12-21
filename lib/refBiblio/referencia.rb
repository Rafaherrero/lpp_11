require 'date'

module RefBiblio
	class Referencia
		include Comparable
		attr_accessor :autor, :titulo, :editorial, :publicacion
		def initialize(autor, titulo, editorial, publicacion)
			@editorial = editorial
			@publicacion = publicacion
			str=""
			autor.each do |a|
				separar = a.split(/\W+/)
				str+=separar[1]
				str+=", "
				unless separar[2].nil?
					str+=separar[2][0]
					str+=". "
				end
				str+=separar[0][0]
				str+="."
				str+=" & " unless a == autor.last
			end
			@autor = str
			
			tit = titulo.split(' ')
			tit.each do |word|
				if word.length > 3
					word.capitalize!
				else
					word.downcase!
				end
				if word == tit[0]
					word.capitalize!
				end
			end

			@titulo = tit.join(' ')
		end

		def <=> (otro)
			if(@autor == otro.autor)
				if(@publicacion == otro.publicacion)
					if(@titulo == otro.titulo)
						return 0
					else
						arr = [@titulo, otro.titulo]
						arr.sort_by!{|t| t.downcase}
						if(arr.first == @titulo)
							return 1
						end
						return -1
					end
				elsif publicacion > otro.publicacion
					return -1
				else
					return 1
				end
			else
				arr = [@autor, otro.autor]
				arr.sort_by!{|t| t.downcase}
				if(arr.first == @autor)
					return -1
				end
				return 1
			end
		end
	end
	
	class Libro < Referencia
		attr_accessor :edicion, :volumen
		def initialize(&block)
			if block_given?
				if block.arity == 1 
					yield self
				else
					instance_eval &block 
				end
			end
		end
		def edicion(edicion)
			@edicion = edicion
		end
		def volumen (volumen)
			@volumen = volumen
		end
		def to_s
			string=""
			string  << @autor << " (" << Date::MONTHNAMES[publicacion.month] << " " << publicacion.day.to_s << ", " << publicacion.year.to_s << "). " << @titulo << " (" << @edicion.to_s << ") (" << @volumen.to_s << "). " << @editorial << "."
		end
	end
	
	class Periodicas < Referencia
		attr_accessor :formato
		def initialize(autor, titulo, editorial, publicacion, formato)
			super(autor,titulo,editorial,publicacion)
			@formato=formato.capitalize
		end
	end

	class ArtPeriodico < Periodicas
		attr_accessor :paginas, :formato
		def initialize(autor, titulo, publicacion, editorial, paginas)
			formato="Papel"
			super(autor,titulo,editorial,publicacion,formato)
			@paginas = paginas
		end
		
		def to_s
			string = ""
			string << @autor << " (" << Date::MONTHNAMES[publicacion.month] << " " << publicacion.day.to_s << ", " << publicacion.year.to_s << "). " << @titulo << ". " << @editorial << ", pp. " << @paginas.to_s << "."
		end
	end
	
	class DocElectronico < Periodicas
		attr_accessor :formato, :url, :fechacceso
		def initialize(autor, titulo, editorial, edicion, publicacion, formato, url, fechacceso)
			super(autor,titulo,editorial,publicacion, formato)
			@url = url
			@fechacceso = fechacceso
			@edicion = edicion
		end
		
		def to_s
			string = ""
			string << @autor << " (" << Date::MONTHNAMES[publicacion.month] << " " << publicacion.day.to_s << ", " << publicacion.year.to_s << "). " << @titulo << @formato << ". " << @editorial << ": " << @edicion << ". Disponible en: " << @url << " (" << Date::MONTHNAMES[fechacceso.month] << " " << fechacceso.day.to_s << ", " << fechacceso.year.to_s << "). "
		end
	end
end
