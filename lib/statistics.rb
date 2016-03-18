#encoding: utf-8
# and open the template in the editor.
module EX2
  
  class Statistics
  
  def compute(marray)
    nivelmax=0
    media_tesoros=0
    #Calcular el nombre del monstruo con el nivel máximo
    # Calcula la media de los tesoros que proporciona cada mosntruo
    marray.each { |i|
      if i.level > nivelmax
        nivelmax= i.level
        nombre_nivel_max = i.name
      end
      media_tesoros += i.prize.treasures
    
    }
    media_tesoros = media_tesoros / marray.length 
    
    marray.each { |i|
        #Monstruos que quitan tesoros ocultos no específicos
      if i.bc.nHiddenTreasures != 0 
        puts i.to_s
      end
      
      #Monstruos que quitan calzado visible
      i.bc.specificVisibleTreasures.each { |j|
        if j == TreasureKind::SHOES
          puts i.to_s
        end
      }
      #Mosntruos que quitan calzado oculto
      i.bc.specificHiddenTreasures.each { |j|
        if j == TreasureKind::SHOES
          puts i.to_s
        end
      }
      
    }
  end
    
    
    
  end
end

