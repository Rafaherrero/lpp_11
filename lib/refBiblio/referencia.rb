require 'date'

module RefBiblio
	class Referencia
# Clase que nos permite representar cada elemento de una referencia
# @author Rafael Herrero

		include Comparable
		attr_accessor :autor, :titulo, :editorial, :publicacion
		def initialize()
		end
# Metodo para guardar el nombre del autor/autores
# @param [autor] autor Nombre del autor a introducir

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
# Metodo para guardar el titulo de la referencia
# @param [titulo] titulo Titulo de la referencia a introducir

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
# Metodo para guardar el editorial de la referencia
# @param [editorial] editorial Editorial de la referencia a introducir		
		
		def editorial(editorial)
			@editorial = editorial
		end
# Metodo para guardar la fecha de publicacion de la referencia
# @param [publicacion] publicacion Fecha de publicacion de la referencia a introducir

		def publicacion (publicacion)
			@publicacion = publicacion
		end
# Metodo para obtener el titulo de la referencia
# @return Titulo de la referencia

		def get_titulo
			@titulo
		end
# Metodo para obtener el autor/autores de la referencia
# @return Autor/autores de la referencia

		def get_autor
			@autor
		end
# Metodo para obtener el editorial de la referencia
# @return Editorial de la referencia

		def get_editorial
			@editorial
		end
# Metodo para obtener la fecha de publicacion de la referencia
# @return Fecha de publicacion de la referencia

		def get_publicacion
			@publicacion
		end
# Método con el que podemos usar el modulo Enumerable
# @param otro Otro elemento a comparar
# @return Devuelve valores entre -1 y 1 segun el orden

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
# Clase que nos permite representar libros de una referencia
# @author Rafael Herrero
		
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
# Metodo que nos permite introducir la edicion del libro
# @param [edicion] edicion Edicion del libro

		def edicion(edicion)
			@edicion = edicion
		end
# Metodo que nos permite introducir el volumen del libro
# @param [volumen] volumen Volumen del libro

		def volumen (volumen)
			@volumen = volumen
		end
# Metodo que nos permite formatear las referencias de los libros
# @return Cadena de caracteres de la referencia del libro formateado
	
		def to_s
			string=""
			string  << @autor << " (" << Date::MONTHNAMES[get_publicacion.month] << " " << get_publicacion.day.to_s << ", " << get_publicacion.year.to_s << "). " << @titulo << " (" << @edicion.to_s << ") (" << @volumen.to_s << "). " << @editorial << "."
		end
	end
	
	class Periodicas < Referencia
# Clase que nos permite representar todas las publicaciones periodicas de una referencia
# @author Rafael Herrero

		attr_accessor :formato
# Metodo para insertar el formato, unico atributo en comun en las publicaciones periodicas
# @param [formato] formato Formato de la publicacion
		
		def initialize(formato)
			@formato = formato.capitalize
		end
	end

	class ArtPeriodico < Periodicas
# Clase que nos permite representar los articulos periodisticos de una publicacion periodica
# @author Rafael Herrero

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
# Metodo que permite insertar el numero de paginas
# @param [paginas] paginas Numero de paginas del articulo periodistico

		def paginas (paginas)
			@paginas = paginas
		end
# Metodo que nos devuelve la referencia del articulo periodistico formateado
# @return String de la referencia del articulo periodistico formateado

		def to_s
			string = ""
			string << @autor << " (" << Date::MONTHNAMES[get_publicacion.month] << " " << get_publicacion.day.to_s << ", " << get_publicacion.year.to_s << "). " << @titulo << ". " << @editorial << ", pp. " << @formato << ", " << @paginas.to_s << " paginas" << "."
		end
	end
	
	class DocElectronico < Periodicas
# Clase que nos permite representar los documentos electronicos de una publicacion periodica
# @author Rafael Herrero

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
# Metodo que permite insertar la edicion
# @param [edicion] edicion Edicion del documento electronico

		def edicion(edicion)
			@edicion = edicion
		end
# Metodo que permite insertar la fecha de acceso al documento
# @param [fechacceso] fechacceso Fecha de acceso al documento electronico

		def fechacceso(fechacceso)
			@fechacceso = fechacceso
		end
# Metodo para almacenar la direccion web del documento electronico
# @param [url] url Direccion web del documento electronico

		def url(url)
			@url = url
		end
# Metodo que nos devuelve la fecha de acceso al documento electronico almacenada
# @return Fecha de acceso al documento electronico

		def get_fechacceso
			@fechacceso
		end
# Metodo que nos devuelve la referencia del documento electronico formateado
# @return String de la referencia del documento electronico formateado

		def to_s
			string = ""
			string << @autor << " (" << Date::MONTHNAMES[get_publicacion.month] << " " << get_publicacion.day.to_s << ", " << get_publicacion.year.to_s << "). " << @titulo << @formato << ". " << @editorial << ": " << @edicion << ". Disponible en: " << @url << " (" << Date::MONTHNAMES[get_fechacceso.month] << " " << get_fechacceso.day.to_s << ", " << get_fechacceso.year.to_s << "). "
		end
	end
end