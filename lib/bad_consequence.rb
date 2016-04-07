#encoding: utf-8
require_relative 'prize.rb'
require_relative 'player.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'treasure_kind.rb'

class BadConsequence
  @@MAXTREASURES=10
  def self.MAXtreasures
    @@MAXTREASURES
  end
  
  
  def initialize(text, lvl, nVisible, nHidden, specificVisible, specificHidden)
    @text=text
    @levels=lvl
    @nVisibleTreasures=nVisible
    @nHiddenTreasures=nHidden
    @specificVisibleTreasures=specificVisible
    @specificHiddenTreasures=specificHidden
  end
  
  def self.newLevelSpecificTreasures(text, lvl, specificVisible, specificHidden)
    new(text,lvl,0,0,specificVisible,specificHidden)
  end
  
  def self.newLevelNumberOfTreasures(text, lvl, nVisible, nHidden)
    new(text,lvl,nVisible,nHidden,Array.new,Array.new)
  end
  
  def self.newDeath(text)
    new(text,Player.MAXlevel,@@MAXTREASURES,@@MAXTREASURES,Array.new,Array.new)
  end
  
  attr_reader :text, :levels, :nHiddenTreasures, :nVisibleTreasures, 
      :specificHiddenTreasures, :specificVisibleTreasures
  private_class_method :new
  
  def isEmpty
    @nHiddenTreasures+@nVisibleTreasures==0 &&
      @specificHiddenTreasures.empty? &&
      @specificVisibleTreasures.empty?
  end
  
  def substractVisibleTreasure t
    
  end
  
  def substractHiddenTreasure t
    
  end
  
  def adjustToFitTreasureLists v, h
    
  end
  
  def to_s
    if @levels==Player.MAXlevel && 
        @nHiddenTreasures==@@MAXTREASURES &&
        @nVisibleTreasures==@@MAXTREASURES
      "Nivel: "+@levels.to_s+"\n"+
                "Descripcion: "+@text+"\n"+
                "Mal rollo muerte\n"
    else
      if @specificHiddenTreasures.empty? && @specificVisibleTreasures.empty?
        "Nivel: "+@levels.to_s+"\n"+
                  "Descripcion: "+@text+"\n"+
                  "Mal rollo quita número tesoros\n"+
                  "Ocultos: "+@nHiddenTreasures.to_s+"\n"+
                  "Visibles: "+@nVisibleTreasures.to_s+"\n"
      else
        "Nivel: "+@levels.to_s+"\n"+
                  "Descripcion: "+@text+"\n"+
                  "Mal rollo quita tesoros especificos\n Ocultos: "+
                  @specificHiddenTreasures.to_s + "\n Visibles: "+
                  @specificVisibleTreasures.to_s+"\n"
      end
    end
  end
end


