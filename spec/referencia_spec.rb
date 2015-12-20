require "spec_helper"
=begin
describe RefBiblio::Referencia do
	before :each do
		@lista1 = Doublylinkedlist::Doublylinkedlist.new
		@lista2 = Doublylinkedlist::Doublylinkedlist.new
		@lista3 = Doublylinkedlist::Doublylinkedlist.new
		@libro1 = RefBiblio::Libro.new(["Alexby 11","Mangel","Sr Cheeto"], "Salseo Gamer", "Temas de hoy", Date.new(2015,1,1), 1, ["9788499984"])
		@revista1 = RefBiblio::ArtRevista.new(["Rafael Herrero","Daniel Ramos"], "Ciencia de hoy", "Grupo Prisa", Date.new(2015,11,17), "Codificacion transversal subatomica en Ruby", 130, ["0395-2037"], ["20","21","22"])
		@periodico1 = RefBiblio::ArtPeriodico.new(["Rafael Herrero","Daniel Ramos"], "El Mundo", "Unidad Editorial Informacion General, S.L.U.", Date.new(2015,11,17), "La regeneracion de las gemas", 130, ["1697-0179"], "Cultura", ["20"])
		@documento1 = RefBiblio::DocElectronico.new(["Rafael Herrero","Daniel Ramos"], "Oficina de Software Libre de la ULL", "Universidad de La Laguna", Date.new(2015,11,17), "Estudio del habitat de las gemas", 45, ["0001-0045"], "PDF", "http://osl.ull.es/noticias/")
	end
	
	describe "La herencia debe de ser la correcta" do
		it "La clase libro es hija de referencia" do
			expect(@libro1).to be_kind_of(RefBiblio::Referencia)
		end
		it "La clase revista es hija de periodicas" do
			expect(@revista1).to be_kind_of(RefBiblio::Periodicas)
		end
		it "La clase periodico es hija de periodicas" do
			expect(@periodico1).to be_kind_of(RefBiblio::Periodicas)
		end
		it "La clase docelectronicos es hija de periodicas" do
			expect(@documento1).to be_kind_of(RefBiblio::Periodicas)
		end
		it "La clase revista es hija de referencia" do
			expect(@revista1).to be_kind_of(RefBiblio::Referencia)
		end
		it "La clase periodico es hija de referencia" do
			expect(@periodico1).to be_kind_of(RefBiblio::Referencia)
		end
		it "La clase docelectronicos es hija de referencia" do
			expect(@documento1).to be_kind_of(RefBiblio::Referencia)
		end
	end
	

	describe "Se puede insertar y extraer de la lista" do
		it "Extraemos del inicio" do
			@lista1.insertar_inicio(@libro1)
			@lista1.insertar_inicio(@revista1)
			@lista1.insertar_inicio(@periodico1)
			@lista1.insertar_inicio(@documento1)
			@lista1.extraer_inicio()
			expect(@lista1.to_s).to eq("|Rafael Herrero, Daniel Ramos.\nEl Mundo\nUnidad Editorial Informacion General, S.L.U.; (November 17, 2015)\nLa regeneracion de las gemas\n130\nISSN: 1697-0179\nSeccion: Cultura\n20, Rafael Herrero, Daniel Ramos.\nCiencia de hoy\nGrupo Prisa; (November 17, 2015)\nCodificacion transversal subatomica en Ruby\n130\nISSN: 0395-2037\n20, 21, 22, Alexby 11, Mangel, Sr Cheeto.\nSalseo Gamer\nTemas de hoy; 1 edition (January 1, 2015)\nISBN-10: 9788499984|")
		end
		
		it "Extraemos del final" do
			@lista1.insertar_final(@libro1)
			@lista1.insertar_final(@revista1)
			@lista1.insertar_final(@periodico1)
			@lista1.insertar_final(@documento1)
			@lista1.extraer_final()
			expect(@lista1.to_s).to eq("|Alexby 11, Mangel, Sr Cheeto.\nSalseo Gamer\nTemas de hoy; 1 edition (January 1, 2015)\nISBN-10: 9788499984, Rafael Herrero, Daniel Ramos.\nCiencia de hoy\nGrupo Prisa; (November 17, 2015)\nCodificacion transversal subatomica en Ruby\n130\nISSN: 0395-2037\n20, 21, 22, Rafael Herrero, Daniel Ramos.\nEl Mundo\nUnidad Editorial Informacion General, S.L.U.; (November 17, 2015)\nLa regeneracion de las gemas\n130\nISSN: 1697-0179\nSeccion: Cultura\n20|")
		end
	end
	
	describe "La lista doblemente enlazada funciona correctamente" do
		it "Insertamos en dos listas en sentidos diferentes siendo el resultado el mismo" do
			@lista1.insertar_inicio(@libro1)
			@lista1.insertar_inicio(@revista1)
			@lista1.insertar_inicio(@periodico1)
			@lista1.insertar_inicio(@documento1)
			@lista2.insertar_final(@documento1)
			@lista2.insertar_final(@periodico1)
			@lista2.insertar_final(@revista1)
			@lista2.insertar_final(@libro1)
			expect(@lista1.to_s).to eq(@lista2.to_s)
			
		end
	end
	
	describe "Probando lista doblemente enlazada practica 9" do
		it "Probando enumerable lista doblemente enlazada" do
			@lista3.insertar_inicio(5)
			@lista3.insertar_inicio(3)
			@lista3.insertar_inicio(2)
			salida = " "
			@lista3.each{|i|
				salida << i.to_s << " "
			}
			expect(salida).to eq (" 2 3 5 ")
		end
		
		it "Probando minimo de lista doblemente enlazada" do
			@lista3.insertar_inicio(2)
			@lista3.insertar_inicio(3)
			@lista3.insertar_inicio(5)
			expect(@lista3.min.to_s).to eq("2")
		end
		
		it "Probando maximo de lista doblemente enlazada" do
			@lista3.insertar_inicio(2)
			@lista3.insertar_inicio(3)
			@lista3.insertar_inicio(5)
			expect(@lista3.max.to_s).to eq("5")
		end
		
		it "Probando reverse de lista doblemente enlazada" do
			@lista3.insertar_inicio(7)
			@lista3.insertar_inicio(9)
			@lista3.insertar_inicio(4)
			salida = " "
			@lista3.reverse_each{|i|
				salida << i.to_s << " "
			}
			expect(salida).to eq(" 7 9 4 ")
		end
		
		it "Probando ordenacion de la lista" do
			@lista3.insertar_inicio(7)
			@lista3.insertar_inicio(2)
			@lista3.insertar_inicio(0)
			@lista3.insertar_inicio(-3)
			@lista3.insertar_inicio(4)
			@lista3.insertar_inicio(16)
			expect(@lista3.sort.to_s).to eq("[-3, 0, 2, 4, 7, 16]")
		end
	end
	
	describe "Probando clase referencia practica 9" do
		it "Probando comparable menor de fecha" do
			expect(@libro1<@revista1).to be true
		end

		it "Probando comparable mayor de fecha" do
			expect(@periodico1>@libro1).to be true
		end
		
		it "Probando comparable menor o igual de fecha" do
			expect(@periodico1<=@revista1).to be true
		end
	
		it "Probando comparable mayor o igual de fecha" do
			expect(@documento1>=@revista1).to be true
		end
	end
end

describe RefBiblio::Libro do
	before :each do
		@libro1 = RefBiblio::Libro.new(["Alexby 11","Mangel","Sr Cheeto"], "Salseo Gamer", "Temas de hoy", Date.new(2015,1,1), 1, ["9788499984"])
		@libro2 = RefBiblio::Libro.new(["Gabriel Garcia Marquez"], "De viaje por Europa del Este", "Literatura Random House", Date.new(2015,1,1), 1, ["978-8439730460"])
		@libro3 = RefBiblio::Libro.new(["Dave Thomas", "Andy Hunt", "Chad Fowler"], "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", "Pragmatic Bookshelf", Date.new(2013,7,7), 4, ["978-1937785499","1937785491"], "(The Facets of Ruby)")
	end

	describe "Debe existir uno o mas autores" do
		it "Se almacenan correctamente los autores y hay un metodo para obtenerlos" do
			expect(@libro1.autor).to eq(["Alexby 11","Mangel","Sr Cheeto"])
			expect(@libro2.autor).to eq(["Gabriel Garcia Marquez"])
			expect(@libro3.autor).to eq(["Dave Thomas", "Andy Hunt", "Chad Fowler"])
		end
	end

	describe "Debe existir un titulo y hay un metodo para obtenerlo" do
		it "Se almacena correctamente el titulo" do
			expect(@libro1.titulo).to eq("Salseo Gamer")
			expect(@libro2.titulo).to eq("De viaje por Europa del Este")
			expect(@libro3.titulo).to eq("Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide")
		end
	end

	describe "Debe existir una editorial y hay un metodo para obtenerla" do
		it "Se almacena correctamente la editorial" do
			expect(@libro1.editorial).to eq("Temas de hoy")
			expect(@libro2.editorial).to eq("Literatura Random House")
			expect(@libro3.editorial).to eq("Pragmatic Bookshelf")
		end
	end

	describe "Debe existir un numero de edicion y hay un metodo para obtenerlo" do
		it "Se almacenan correctamente las ediciones" do
			expect(@libro1.edicion).to eq(1)
			expect(@libro2.edicion).to eq(1)
			expect(@libro3.edicion).to eq(4)
		end
	end 

	describe "Debe existir una fecha de publicacion y hay un metodo para obtenerla" do
		it "Se almacenan correctamente las fechas" do
			expect(@libro1.publicacion).to eq(Date.new(2015,1,1))
			expect(@libro2.publicacion).to eq(Date.new(2015,1,1))
			expect(@libro3.publicacion).to eq(Date.new(2013,07,07))
		end
	end

	describe "Debe existir uno o mas numeros ISBN y hay un metodo para obtenerlos" do
		it "En el libro 1 solo esta el ISB-10" do
			expect(@libro1.isbn).to eq(["9788499984"])
		end
		it "En el libro 2 solo esta el ISB-13" do
			expect(@libro2.isbn).to eq(["978-8439730460"])
		end
		it "En el libro 3 estan ambos" do
			expect(@libro3.isbn).to eq(["978-1937785499","1937785491"])
		end
	end

	describe "Debe existir o no una serie y hay un metodo para obtenerla" do
		it "En el libro 1 no debe haber serie" do
			expect(@libro1.serie).to eq(nil)
		end
		it "En el libro 2 no debe haber serie" do
			expect(@libro2.serie).to eq(nil)
		end
		it "En el libro 3 debe haber una serie" do
			expect(@libro3.serie).to eq("(The Facets of Ruby)")
		end
	end

	describe "Existe un metodo para obtener la referencia formateada" do
		it "Comprobar el formato del libro 1" do
			expect(@libro1.to_s).to eq("Alexby 11, Mangel, Sr Cheeto.\nSalseo Gamer\nTemas de hoy; 1 edition (January 1, 2015)\nISBN-10: 9788499984")
		end
		it "Comprobar el formato del libro 2" do
			expect(@libro2.to_s).to eq("Gabriel Garcia Marquez.\nDe viaje por Europa del Este\nLiteratura Random House; 1 edition (January 1, 2015)\nISBN-13: 978-8439730460")
		end
		it "Comprobar el formato del libro 3" do
			expect(@libro3.to_s).to eq("Dave Thomas, Andy Hunt, Chad Fowler.\nProgramming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide\n(The Facets of Ruby)\nPragmatic Bookshelf; 4 edition (July 7, 2013)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
		end
	end

	describe "Comprobaciones de tipo" do
		it "Los autores deben ser un array" do
			expect(@libro3.autor).to be_a(Array)
		end
		it "El autor 1 debe ser un string" do
			expect(@libro3.autor[0]).to be_a(String)
		end
		it "El autor 2 debe ser un string" do
			expect(@libro3.autor[1]).to be_a(String)
		end
		it "El autor 3 debe ser un string" do
			expect(@libro3.autor[2]).to be_a(String)
		end
		it "El titulo debe ser un string" do
			expect(@libro3.titulo).to be_a(String)
		end
		it "La serie debe ser un string" do
			expect(@libro3.serie).to be_a(String)
		end
		it "La serie debe ser nula" do
			expect(@libro1.serie).to be_nil
		end
		it "La editorial debe ser un string" do
			expect(@libro3.editorial).to be_a(String)
		end
		it "La edicion debe ser un numero" do
			expect(@libro3.edicion).to be_a(Numeric)
		end
		it "La fecha de publicacion debe ser una fecha" do
			expect(@libro3.publicacion).to be_a(Date)
		end
		it "El ISBN debe ser un array" do
			expect(@libro3.isbn).to be_a(Array)
		end
		it "El ISBN 10 debe ser un string" do
			expect(@libro3.isbn[0]).to be_a(String)
		end
		it "El ISBN 13 debe ser un string" do
			expect(@libro3.isbn[1]).to be_a(String)
		end
	end
end

describe RefBiblio::ArtRevista do
	before :each do
		@revista1 = RefBiblio::ArtRevista.new(["Rafael Herrero","Daniel Ramos"], "Ciencia de hoy", "Grupo Prisa", Date.new(2015,11,17), "Codificacion transversal subatomica en Ruby", 130, ["0395-2037"], ["20","21","22"])
		@revista2 = RefBiblio::ArtRevista.new(["Gualberto Buela Casal"], "Psicothema", "Dialnet", Date.new(2003,1,1), "Evaluacion de la calidad de los articulos y de las revistas cientificas", 15, ["0214-9915"], ["23-35"])
	end
	
	describe "Debe existir uno o mas autores" do
		it "Se almacenan correctamente los autores y hay un metodo para obtenerlos" do
			expect(@revista1.autor).to eq(["Rafael Herrero","Daniel Ramos"])
			expect(@revista2.autor).to eq(["Gualberto Buela Casal"])
		end
	end
	
	describe "Debe existir un titulo y hay un metodo para obtenerlo" do
		it "Se almacena correctamente el titulo" do
			expect(@revista1.titulo).to eq("Ciencia de hoy")
			expect(@revista2.titulo).to eq("Psicothema")
		end
	end
	
	describe "Debe existir una editorial y hay un metodo para obtenerla" do
		it "Se almacena correctamente la editorial" do
			expect(@revista1.editorial).to eq("Grupo Prisa")
			expect(@revista2.editorial).to eq("Dialnet")
		end
	end
	
	describe "Debe existir una fecha de publicacion y hay un metodo para obtenerla" do
		it "Se almacenan correctamente las fechas" do
			expect(@revista1.publicacion).to eq(Date.new(2015,11,17))
			expect(@revista2.publicacion).to eq(Date.new(2003,1,1))
		end
	end
	
	describe "Debe existir un numero de revista y hay un metodo para obtenerla" do
		it "Se almacenan correctamente los numeros de revista" do
			expect(@revista1.numero).to eq(130)
			expect(@revista2.numero).to eq(15)
		end
	end
	
	describe "Debe existir un ISSN y hay un metodo para obtenerla" do
		it "Se almacena correctamente el ISSN" do
			expect(@revista1.issn).to eq(["0395-2037"])
			expect(@revista2.issn).to eq(["0214-9915"])
		end
	end
	
	describe "Debe existir un titulo de articulo y hay un metodo para obtenerla" do
		it "Se almacena el titulo del articulo correctamente" do
			expect(@revista1.tituloarticulo).to eq("Codificacion transversal subatomica en Ruby")
			expect(@revista2.tituloarticulo).to eq("Evaluacion de la calidad de los articulos y de las revistas cientificas")
		end
	end
	
	describe "Debe existir un numero de pagina para los articulos" do
		it "Se almacena los numeros de pagina de los articulos en la revista" do
			expect(@revista1.pagina).to eq(["20","21","22"])
			expect(@revista2.pagina).to eq(["23-35"])
		end
	end
	
	describe "Existe un metodo para obtener la referencia formateada" do
		it "Comprobar el formato de lax revistas" do
			expect(@revista1.to_s).to eq("Rafael Herrero, Daniel Ramos.\nCiencia de hoy\nGrupo Prisa; (November 17, 2015)\nCodificacion transversal subatomica en Ruby\n130\nISSN: 0395-2037\n20, 21, 22")
			expect(@revista2.to_s).to eq("Gualberto Buela Casal.\nPsicothema\nDialnet; (January 1, 2003)\nEvaluacion de la calidad de los articulos y de las revistas cientificas\n15\nISSN: 0214-9915\n23-35")
		end
	end
	
	describe "Comprobaciones de tipo" do
		it "Los autores deben ser un array" do
			expect(@revista1.autor).to be_a(Array)
		end
		it "El autor 1 debe ser un string" do
			expect(@revista1.autor[0]).to be_a(String)
		end
		it "El autor 2 debe ser un string" do
			expect(@revista1.autor[1]).to be_a(String)
		end
		it "El titulo de la revista debe ser un string" do
			expect(@revista1.titulo).to be_a(String)
		end
		it "La editorial debe ser un string" do
			expect(@revista1.editorial).to be_a(String)
		end
		it "La fecha de publicacion debe ser una fecha" do
			expect(@revista1.publicacion).to be_a(Date)
		end
		it "El titulo del articulo debe ser un string" do
			expect(@revista1.tituloarticulo).to be_a(String)
		end
		it "El ISBN debe ser un array" do
			expect(@revista1.issn).to be_a(Array)
		end
		it "El ISSN debe ser un string" do
			expect(@revista1.issn[0]).to be_a(String)
		end
		it "El numero de la revista debe ser un numero" do
			expect(@revista1.numero).to be_a(Numeric)
		end
		it "El numero de las paginas debe ser un array" do
			expect(@revista1.pagina).to be_a(Array)
			expect(@revista2.pagina).to be_a(Array)
		end
	end
	
	
	describe RefBiblio::ArtPeriodico do
	before :each do
		@periodico1 = RefBiblio::ArtPeriodico.new(["Rafael Herrero","Daniel Ramos"], "El Mundo", "Unidad Editorial Informacion General, S.L.U.", Date.new(2015,11,17), "La regeneracion de las gemas", 130, ["1697-0179"], "Cultura", ["20"])
		@periodico2 = RefBiblio::ArtPeriodico.new(["Elvira Lindo"], "El Pais", "Grupo Prisa", Date.new(2015,10,31), "Ser chica Almodovar", 150, ["0213-4608"], "Revista Sabado", ["30-32"])
	end
	
	describe "Debe existir uno o mas autores" do
		it "Se almacenan correctamente los autores y hay un metodo para obtenerlos" do
			expect(@periodico1.autor).to eq(["Rafael Herrero","Daniel Ramos"])
			expect(@periodico2.autor).to eq(["Elvira Lindo"])
		end
	end
	
	describe "Debe existir un titulo y hay un metodo para obtenerlo" do
		it "Se almacena correctamente el titulo" do
			expect(@periodico1.titulo).to eq("El Mundo")
			expect(@periodico2.titulo).to eq("El Pais")
		end
	end
	
	describe "Debe existir una editorial y hay un metodo para obtenerla" do
		it "Se almacena correctamente la editorial" do
			expect(@periodico1.editorial).to eq("Unidad Editorial Informacion General, S.L.U.")
			expect(@periodico2.editorial).to eq("Grupo Prisa")
		end
	end
	
	describe "Debe existir una fecha de publicacion y hay un metodo para obtenerla" do
		it "Se almacenan correctamente las fechas" do
			expect(@periodico1.publicacion).to eq(Date.new(2015,11,17))
			expect(@periodico2.publicacion).to eq(Date.new(2015,10,31))
		end
	end
	
	describe "Debe existir un titulo de articulo y hay un metodo para obtenerla" do
		it "Se almacena el titulo del articulo correctamente" do
			expect(@periodico1.tituloarticulo).to eq("La regeneracion de las gemas")
			expect(@periodico2.tituloarticulo).to eq("Ser chica Almodovar")
		end
	end
	
	describe "Debe existir un numero de periodico y hay un metodo para obtenerla" do
		it "Se almacenan correctamente los numeros de periodicos" do
			expect(@periodico1.numero).to eq(130)
			expect(@periodico2.numero).to eq(150)
		end
	end

	describe "Debe existir un ISSN y hay un metodo para obtenerla" do
		it "Se almacena correctamente el ISSN" do
			expect(@periodico1.issn).to eq(["1697-0179"])
			expect(@periodico2.issn).to eq(["0213-4608"])
		end
	end
	
	describe "Debe existir un numero de pagina para los articulos" do
		it "Se almacena los numeros de pagina de los articulos en la revista" do
			expect(@periodico1.pagina).to eq(["20"])
			expect(@periodico2.pagina).to eq(["30-32"])
		end
	end
	
	describe "Existe un metodo para obtener la referencia formateada" do
		it "Comprobar el formato de los periodicos" do
			expect(@periodico1.to_s).to eq("Rafael Herrero, Daniel Ramos.\nEl Mundo\nUnidad Editorial Informacion General, S.L.U.; (November 17, 2015)\nLa regeneracion de las gemas\n130\nISSN: 1697-0179\nSeccion: Cultura\n20")
			expect(@periodico2.to_s).to eq("Elvira Lindo.\nEl Pais\nGrupo Prisa; (October 31, 2015)\nSer chica Almodovar\n150\nISSN: 0213-4608\nSeccion: Revista Sabado\n30-32")
		end
	end
	
	describe "Comprobaciones de tipo" do
		it "Los autores deben ser un array" do
			expect(@periodico1.autor).to be_a(Array)
		end
		it "El autor 1 debe ser un string" do
			expect(@periodico1.autor[0]).to be_a(String)
		end
		it "El autor 2 debe ser un string" do
			expect(@periodico1.autor[1]).to be_a(String)
		end
		it "El titulo del periodico debe ser un string" do
			expect(@periodico1.titulo).to be_a(String)
		end
		it "La editorial debe ser un string" do
			expect(@periodico1.editorial).to be_a(String)
		end
		it "La fecha de publicacion debe ser una fecha" do
			expect(@periodico1.publicacion).to be_a(Date)
		end
		it "El titulo del articulo debe ser un string" do
			expect(@periodico1.tituloarticulo).to be_a(String)
		end
		it "El ISBN debe ser un array" do
			expect(@periodico1.issn).to be_a(Array)
		end
		it "El ISSN debe ser un string" do
			expect(@periodico1.issn[0]).to be_a(String)
		end
		it "El numero del periodico debe ser un numero" do
			expect(@periodico1.numero).to be_a(Numeric)
		end
		it "La seccion debe ser un string" do
			expect(@periodico1.seccion).to be_a(String)
		end
		it "El numero de las paginas debe ser un array" do
			expect(@periodico1.pagina).to be_a(Array)
			expect(@revista2.pagina).to be_a(Array)
		end
	end
	
end

describe RefBiblio::DocElectronico do
	before :each do
		@documento1 = RefBiblio::DocElectronico.new(["Rafael Herrero","Daniel Ramos"], "Oficina de Software Libre de la ULL", "Universidad de La Laguna", Date.new(2015,11,17), "Estudio del habitat de las gemas", 45, ["0001-0045"], "PDF", "http://osl.ull.es/noticias/")
		@documento2 = RefBiblio::DocElectronico.new(["Ministerio de Hacienda y Administraciones Publicas"], "BOE. Boletin Oficial del Estado", "Gobierno de Espana", Date.new(2015,11,17), "Real Decreto 1021/2015, de 13 de noviembre, por el que se establece la obligacion de identificar la residencia fiscal de las personas que ostenten la titularidad o el control de determinadas cuentas financieras y de informar acerca de las mismas en el ambito de la asistencia mutua.", 12399, ["0001-0275"], "PDF", "http://www.boe.es/boe/dias/2015/11/17/pdfs/BOE-A-2015-12399.pdf")
	end
	
	describe "Debe existir uno o mas autores" do
		it "Se almacenan correctamente los autores y hay un metodo para obtenerlos" do
			expect(@documento1.autor).to eq(["Rafael Herrero","Daniel Ramos"])
			expect(@documento2.autor).to eq(["Ministerio de Hacienda y Administraciones Publicas"])
		end
	end
	
	describe "Debe existir un titulo y hay un metodo para obtenerlo" do
		it "Se almacena correctamente el titulo" do
			expect(@documento1.titulo).to eq("Oficina de Software Libre de la ULL")
			expect(@documento2.titulo).to eq("BOE. Boletin Oficial del Estado")
		end
	end
	
	describe "Debe existir una editorial y hay un metodo para obtenerla" do
		it "Se almacena correctamente la editorial" do
			expect(@documento1.editorial).to eq("Universidad de La Laguna")
			expect(@documento2.editorial).to eq("Gobierno de Espana")
		end
	end
	
	describe "Debe existir una fecha de publicacion y hay un metodo para obtenerla" do
		it "Se almacenan correctamente las fechas" do
			expect(@documento1.publicacion).to eq(Date.new(2015,11,17))
			expect(@documento2.publicacion).to eq(Date.new(2015,11,17))
		end
	end
	
	describe "Debe existir un titulo de articulo y hay un metodo para obtenerla" do
		it "Se almacena el titulo del articulo correctamente" do
			expect(@documento1.tituloarticulo).to eq("Estudio del habitat de las gemas")
			expect(@documento2.tituloarticulo).to eq("Real Decreto 1021/2015, de 13 de noviembre, por el que se establece la obligacion de identificar la residencia fiscal de las personas que ostenten la titularidad o el control de determinadas cuentas financieras y de informar acerca de las mismas en el ambito de la asistencia mutua.")
		end
	end
	
	describe "Debe existir un numero de documento y hay un metodo para obtenerla" do
		it "Se almacenan correctamente los numeros de documentos" do
			expect(@documento1.numero).to eq(45)
			expect(@documento2.numero).to eq(12399)
		end
	end
	
	describe "Debe existir un ISSN y hay un metodo para obtenerla" do
		it "Se almacena correctamente el ISSN" do
			expect(@documento1.issn).to eq(["0001-0045"])
			expect(@documento2.issn).to eq(["0001-0275"])
		end
	end
	
	describe "Debe existir un formato y hay un metodo para obtenerlo" do
		it "Se almacena correctamente el formato del documento" do
			expect(@documento1.formato).to eq("PDF")
			expect(@documento2.formato).to eq("PDF")
		end
	end
	
	describe "Debe existir un enlace web y hay un metodo para obtenerlo" do
		it "Se almacena correctamente la direccion del documento" do
			expect(@documento1.url).to eq("http://osl.ull.es/noticias/")
			expect(@documento2.url).to eq("http://www.boe.es/boe/dias/2015/11/17/pdfs/BOE-A-2015-12399.pdf")
		end
	end
	
	describe "Existe un metodo para obtener la referencia formateada" do
		it "Comprobar el formato de los documentos" do
			expect(@documento1.to_s).to eq("Rafael Herrero, Daniel Ramos.\nOficina de Software Libre de la ULL\nUniversidad de La Laguna; (November 17, 2015)\nEstudio del habitat de las gemas\n45\nISSN: 0001-0045\nFormato: PDF URL: http://osl.ull.es/noticias/\n")
			expect(@documento2.to_s).to eq("Ministerio de Hacienda y Administraciones Publicas.\nBOE. Boletin Oficial del Estado\nGobierno de Espana; (November 17, 2015)\nReal Decreto 1021/2015, de 13 de noviembre, por el que se establece la obligacion de identificar la residencia fiscal de las personas que ostenten la titularidad o el control de determinadas cuentas financieras y de informar acerca de las mismas en el ambito de la asistencia mutua.\n12399\nISSN: 0001-0275\nFormato: PDF URL: http://www.boe.es/boe/dias/2015/11/17/pdfs/BOE-A-2015-12399.pdf\n")
		end
	end
	
	describe "Comprobaciones de tipo" do
		it "Los autores deben ser un array" do
			expect(@documento1.autor).to be_a(Array)
		end
		it "El autor 1 debe ser un string" do
			expect(@documento1.autor[0]).to be_a(String)
		end
		it "El autor 2 debe ser un string" do
			expect(@documento1.autor[1]).to be_a(String)
		end
		it "El titulo del periodico debe ser un string" do
			expect(@documento1.titulo).to be_a(String)
		end
		it "La editorial debe ser un string" do
			expect(@documento1.editorial).to be_a(String)
		end
		it "La fecha de publicacion debe ser una fecha" do
			expect(@documento1.publicacion).to be_a(Date)
		end
		it "El titulo del articulo debe ser un string" do
			expect(@documento1.tituloarticulo).to be_a(String)
		end
		it "El ISBN debe ser un array" do
			expect(@documento1.issn).to be_a(Array)
		end
		it "El ISSN debe ser un string" do
			expect(@documento1.issn[0]).to be_a(String)
		end
		it "El numero del documento debe ser un numero" do
			expect(@documento1.numero).to be_a(Numeric)
		end
		it "La formato debe ser un string" do
			expect(@documento1.formato).to be_a(String)
		end
		it "El link del documento debe ser un string" do
			expect(@documento1.url).to be_a(String)
		end
	end
	
end

end

=end
