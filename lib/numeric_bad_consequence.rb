#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'bad_consequence.rb'

module NapakalakiGame
  
  class NumericBadConsequence < BadConsequence

    public_class_method :new

    def initialize(text, levels, nVisibleTreasures, nHiddenTreasures)
      super(text, levels)
      @nVisibleTreasures = nVisibleTreasures
      @nHiddenTreasures = nHiddenTreasures
    end
    
    def getNVisibleTreasures()
      @nVisibleTreasures
    end
    
    def getNHiddenTreasures()
      @nHiddenTreasures
    end    
    
    def isEmpty
      (@nHiddenTreasures+@nVisibleTreasures)==0
    end
    
    def substractVisibleTreasure(t)#Treasure t
      @nVisibleTreasures = (@nVisibleTreasures-1) < 0 ? 0 : @nVisibleTreasures-1 ;
  #     Exactamente igual que en java, if else compacto
    end
    
    def substractHiddenTreasure(t)#Treasure t
      @nHiddenTreasures = (@nHiddenTreasures-1) < 0 ? 0 : @nHiddenTreasures-1 ;
  #     Exactamente igual que en java, if else compacto
    end
    
    def adjustToFitTreasureLists v, h #v:Treasure[], h:Treasure[]
  #   Número de tesoros visibles a quitar 
      minVisibleTreasures =  @nVisibleTreasures > v.length ? v.length : @nVisibleTreasures
  #   Número de tesoros ocultos a quitar
      minHiddenTreasures = @nHiddenTreasures > h.length ? h.length : @nHiddenTreasures
      NumericBadConsequence.new(@text, 0, minVisibleTreasures, minHiddenTreasures) #return
    end

    def to_s
      @textoIntroduccion + "\n\tTexto = " + @text.to_s + 
           "\n\tLevels = " + @levels.to_s +
           "\n\tNumber of Visible Treasures = " + @nVisibleTreasures.to_s +
           "\n\tNumber of Hidden Treasures = " + @nHiddenTreasures.to_s # return
    end
    
  end
  
end
