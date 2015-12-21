require 'date'

module RefBiblio
	class Referencia
		include Comparable
		attr_accessor :autor, :titulo, :editorial, :publicacion
		def initialize()
		end
		def autor (autor)
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
		end
		def titulo (titulo)
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
			@titulo = tit.join(' ')
		end
		def editorial(editorial)
			@editorial = editorial
		end
		def publicacion (publicacion)
			@publicacion = publicacion
		end
		def get_titulo
			@titulo
		end
		def get_autor
			@autor
		end
		def get_editorial
			@editorial
		end
		def get_publicacion
			@publicacion
		end

		def <=> (otro)
			if(@autor == otro.get_autor)
				if(@publicacion == otro.get_publicacion)
					if(@titulo == otro.get_titulo)
						return 0
					else
						arr = [@titulo, otro.get_titulo]
						arr.sort_by!{|t| t.downcase}
						if(arr.first == @titulo)
							return 1
						end
						return -1
					end
				elsif publicacion > otro.get_publicacion
					return -1
				else
					return 1
				end
			else
				arr = [@autor, otro.get_autor]
				arr.sort_by!{|t| t.downcase}
				if(arr.first == @autor)
					return -1
				end
				return 1
			end
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
			string  << @autor << " (" << Date::MONTHNAMES[get_publicacion.month] << " " << get_publicacion.day.to_s << ", " << get_publicacion.year.to_s << "). " << @titulo << " (" << @edicion.to_s << ") (" << @volumen.to_s << "). " << @editorial << "."
		end
	end
	
	class Periodicas < Referencia
		attr_accessor :formato
		def initialize(formato)
			@formato = formato.capitalize
		end
	end

	class ArtPeriodico < Periodicas
		attr_accessor :paginas, :formato
		def initialize(formato, &block)
			if block_given?
				if block.arity == 1 
					yield self
				else
					instance_eval &block 
				end
			end
			super(formato)
		end
		def paginas (paginas)
			@paginas = paginas
		end
		def to_s
			string = ""
			string << @autor << " (" << Date::MONTHNAMES[get_publicacion.month] << " " << get_publicacion.day.to_s << ", " << get_publicacion.year.to_s << "). " << @titulo << ". " << @editorial << ", pp. " << @formato << ", " << @paginas.to_s << " paginas" << "."
		end
	end
	
	class DocElectronico < Periodicas
		attr_accessor :formato, :url, :fechacceso
		def initialize(formato, &block)
			if block_given?
				if block.arity == 1 
					yield self
				else
					instance_eval &block 
				end
			end
			super(formato)
		end
		def edicion(edicion)
			@edicion = edicion
		end
		def fechacceso(fechacceso)
			@fechacceso = fechacceso
		end
		def url(url)
			@url = url
		end
		def get_fechacceso
			@fechacceso
		end
		def to_s
			string = ""
			string << @autor << " (" << Date::MONTHNAMES[get_publicacion.month] << " " << get_publicacion.day.to_s << ", " << get_publicacion.year.to_s << "). " << @titulo << @formato << ". " << @editorial << ": " << @edicion << ". Disponible en: " << @url << " (" << Date::MONTHNAMES[get_fechacceso.month] << " " << get_fechacceso.day.to_s << ", " << get_fechacceso.year.to_s << "). "
		end
	end
end