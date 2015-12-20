module Doublylinkedlist
	Struct.new("Nodo", :ant, :valor, :sig)

	class Doublylinkedlist
	    include Enumerable
	    def initialize()
			@inicio = nil
			@final = nil
		end
		
		def to_s
			actual = @inicio
			cadena = "|"
				while !actual.nil?
					cadena << actual[:valor].to_s

					if !actual[:sig].nil?
						cadena << ", "
					end

					actual = actual[:sig]
				end
			cadena << "|"
			return cadena
		end
		
		def insertar_inicio(val)
			if @inicio.nil?
				@inicio = Struct::Nodo.new(nil, val, nil)
				@final = @inicio
			else
				copia = @inicio
				@inicio = Struct::Nodo.new(nil, val, copia)
				copia[:ant] = @inicio
			end
		end
		
		def insertar_final(val)
			if @final.nil?
				@inicio = Struct::Nodo.new(nil, val, nil)
				@final = @inicio
			else
			    copia = @final
				@final[:sig] = Struct::Nodo.new(copia, val, nil)
				copia2 = @final[:sig]
				@final = copia2
			end
		end
		
		def extraer_inicio()
			
			if !@inicio.nil?

				if @inicio[:sig].nil? && @final[:sig].nil?
					@inicio = nil
					@final = nil
				
				else
					@inicio = @inicio[:sig]
					@inicio[:ant] = nil
				end

			else
				raise RuntimeError, "La lista esta vacia"
			end
		end
		
		def extraer_final()
			
			if !@inicio.nil?

				if @inicio[:sig].nil? && @final[:sig].nil?
					@inicio = nil
					@final = nil
				
				else
					@final = @final[:ant]
					@final[:sig] = nil
				end

			else
				raise RuntimeError, "La lista esta vacia"
			end
		end
		
		def tamano()
			if !@inicio.nil?

				contador = 1
				copia = @inicio

				while !copia[:sig].nil?
					contador += 1
					copia2 = copia[:sig]
					copia = copia2
				end
			end
			return contador
		end
		
		def posicion (pos)
		 	if @inicio.nil?
		 		raise RuntimeError, "La lista esta vacia"
		 	end

		 	if pos<0 || pos>tamano-1
		 		raise RuntimeError, "La posicion no es correcta"
		 	end

	 		contador=0
	 		copia=@inicio
				while contador<pos && !copia.nil?
					copia2 = copia[:sig]
		 			copia = copia2
		 			contador += 1
		 		end
		 	
			return copia[:valor]
		end
		
		def each (&block)
			copia = @inicio
			while !copia.nil?
				block.call(copia[:valor])
				copia = copia[:sig]
			end
		end
		def ordenar! 
			cambio = true
			while cambio
				cambio = false
				i = @inicio
				i_1 = @inicio[:sig]
				while i_1 != nil
					if(i[:valor] > i_1[:valor])
						i[:valor], i_1[:valor] = i_1[:valor], i[:valor]
						cambio = true
					end
					i = i_1
					i_1 = i_1[:sig]
				end
			end
		end
	end
end