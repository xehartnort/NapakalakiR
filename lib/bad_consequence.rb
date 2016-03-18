#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'treasure_kind.rb'

class BadConsequence
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
    new(text,10,10,10,Array.new,Array.new)
  end
  
  attr_reader :text, :levels, :nHiddenTreasures, :nVisibleTreasures, 
      :specificHiddenTreasures, :specificVisibleTreasures
  private_class_method :new
  
  def to_s
    if @levels==10 && @nHiddenTreasures==10 && @nVisibleTreasures==10
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
#main local
if __FILE__ == $0
  puts BadConsequence.newLevelSpecificTreasures("Especifico", 3, [TreasureKind::ONEHAND], [TreasureKind::ONEHAND]).to_s
  puts BadConsequence.newLevelNumberOfTreasures("Numero",3,3,3).to_s,"\n"
  puts  BadConsequence.newDeath("Te mueres").to_s
end


