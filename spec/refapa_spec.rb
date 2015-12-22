require "spec_helper"

describe RefAPA::Refapa do
    before :all do 
        @libro1 = RefBiblio::Libro.new() do
            autor      ["Alexby 11","Mangel Ros","Sr Cheeto"]
            titulo      "Salseo Gamer"
            editorial   "Temas de hoy"
            publicacion Date.new(2015,1,1)
            edicion     1
            volumen     1
        end
        @periodico1 = RefBiblio::ArtPeriodico.new("Papel") do
            autor       ["Rafael Herrero","Daniel Ramos"]
            titulo      "La regeneracion de las gemas"
            editorial   "El Mundo"
            publicacion Date.new(2015,11,17)
            paginas     130
        end
        @documento1 = RefBiblio::DocElectronico.new("PDF") do
            autor       ["Rafael Herrero","Daniel Ramos"]
            titulo      "Estudio del habitat de las gemas"
            editorial   "Universidad de La Laguna"
            publicacion Date.new(2015,11,17)
            edicion     "Oficina de Software Libre de la ULL"
            url         "http://osl.ull.es/noticias/"
            fechacceso  Date.new(2015,12,9)
        end
    end
    before :each do
        @APA = RefAPA::Refapa.new
        @lista = Doublylinkedlist::Doublylinkedlist.new
    end
    describe "Probando lista"do
    	it "Probando enumerable lista doblemente enlazada" do
			@lista.insertar_inicio(5)
			@lista.insertar_inicio(3)
			@lista.insertar_inicio(2)
			salida = " "
			@lista.each{|i|
				salida << i.to_s << " "
			}
			expect(salida).to eq (" 2 3 5 ")
		end
	end
	describe "Probando herencia" do
        it "Bien heredado" do
		    expect(RefBiblio::Libro).to be_kind_of(BasicObject)
		    expect(RefBiblio::ArtPeriodico).to be_kind_of(BasicObject)
		    expect(RefBiblio::DocElectronico).to be_kind_of(BasicObject)
		    expect(RefAPA::Refapa).to be_kind_of(BasicObject)
	    end
    end
    describe "Insertar elementos" do
        it "Insertar libro y bien formateado" do
            @APA.insertar(@libro1)
            expect(@APA.to_s).to eq("11, A. & Ros, M. & Cheeto, S. (January 1, 2015). Salseo Gamer (1) (1). Temas de hoy.\n")
        end

        it "Insertar periodico y bien formateado" do
            @APA.insertar(@periodico1)
            expect(@APA.to_s).to eq("Herrero, R. & Ramos, D. (November 17, 2015). La Regeneracion de las Gemas. El Mundo, pp. Papel, 130 paginas.\n")
        end

        it "Insertar documento electronico" do
            @APA.insertar(@documento1)
            expect(@APA.to_s).to eq("Herrero, R. & Ramos, D. (November 17, 2015). Estudio del Habitat de las GemasPdf. Universidad de La Laguna: Oficina de Software Libre de la ULL. Disponible en: http://osl.ull.es/noticias/ (December 9, 2015). \n")
        end

        it "Insertar todo y bien formateado" do
        @APA.insertar(@libro1)
        @APA.insertar(@periodico1)
        @APA.insertar(@documento1)
        expect(@APA.to_s).to eq("11, A. & Ros, M. & Cheeto, S. (January 1, 2015). Salseo Gamer (1) (1). Temas de hoy.\nHerrero, R. & Ramos, D. (November 17, 2015). La Regeneracion de las Gemas. El Mundo, pp. Papel, 130 paginas.\nHerrero, R. & Ramos, D. (November 17, 2015). Estudio del Habitat de las GemasPdf. Universidad de La Laguna: Oficina de Software Libre de la ULL. Disponible en: http://osl.ull.es/noticias/ (December 9, 2015). \n")
        end
    end
end
