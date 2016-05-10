#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'bad_consequence.rb'

module NapakalakiGame
  
  class SpecificBadConsequence < BadConsequence
    
    public_class_method :new

    def initialize(text, levels, specificVisibleTreasures, specificHiddenTreasures)
      super(text,levels)
      @specificVisibleTreasures = specificVisibleTreasures
      @specificHiddenTreasures = specificHiddenTreasures
    end
    
    def isEmpty
      @specificHiddenTreasures.empty? &&
        @specificVisibleTreasures.empty?
    end
    
    def substractVisibleTreasure t #Treasure t
        if @specificVisibleTreasures.count(t.type)==1 #Si hay solo uno
          @specificVisibleTreasures.delete(t.type)
        else # si hay más de uno, sólo borramos el primero
          i = @specificVisibleTreasures.find_index(t.type)
          @specificVisibleTreasures.delete_at(i)
        end
    end
    
    def substractHiddenTreasure t #Treasure t
        if @specificHiddenTreasures.count(t.type)==1 #Si hay solo uno
          @specificHiddenTreasures.delete(t.type)
        else # si hay más de uno, sólo borramos el primero
          i = @specificHiddenTreasures.find_index(t.type)
          @specificHiddenTreasures.delete_at(i)
        end
    end
    
    def adjustToFitTreasureLists v, h #v:Treasure[], h:Treasure[]
      newVisibleTreasuresBad = Array.new
      newHiddenTreasuresBad = Array.new
      copyOfspecificVisibleTreasures = @specificVisibleTreasures.clone
      copyOfspecificHiddenTreasures = @specificHiddenTreasures.clone

      v.each do |t|
        if copyOfspecificVisibleTreasures.include? t.type
          index = copyOfspecificVisibleTreasures.index(t.type)
          puts index
          copyOfspecificVisibleTreasures.delete_at(index)
          newVisibleTreasuresBad << t.type
        end
      end

      h.each do |t|
        if copyOfspecificHiddenTreasures.include? t.type
          index = copyOfspecificHiddenTreasures.index(t.type)
          puts index
          copyOfspecificHiddenTreasures.delete_at(index)
          newHiddenTreasuresBad << t.type
        end
      end
      SpecificBadConsequence.new(@text, 0, newVisibleTreasuresBad, newHiddenTreasuresBad) #return
    end

    def to_s
      textoInicial = "\n\tTexto = " + @text.to_s + 
        "\n\tLevels = " + @levels.to_s
      textoArrayVisibleTreasures = " \n\tArray Specific Visible Treasures = " +
                                  @specificVisibleTreasures.to_s
      textoArrayHiddenTreasures = " \n\tArray Specific Hidden Treasures = " +
                                  @specificHiddenTreasures.to_s

      @textoIntroduccion+textoInicial+textoArrayVisibleTreasures+textoArrayHiddenTreasures #return
    end 
  end
end