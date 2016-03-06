#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class BadConsequence
  def initialize(text, lvl, nVisible, nHidden, specificVisible, specificHidden)
    @text=text
    @levels=lvl
    @nVisibleTreasures=nVisible
    @nHiddenTreasures=nHidden
    @specificVisibleTreasures=specificVisible
    @specificHiddenTreasures=specificHidden
  end
  def newLevelSpecificTreasures(text, lvl, specificVisible, specificHidden)
    self.new(text,lvl,0,0,specificVisible,specificHidden)
  end
  def newLevelNumberOfTreasures(text, lvl, nVisible, nHidden)
    self.new(text,lvl,nVisible,nHidden,Array.new,Array.new)
  end
  def newDead(text)
    self.new(text,10,10,10,Array.new,Array.new)
  end
  
  attr_reader :text, :levels, :nHiddenTreasures, :nVisibleTreasures, 
      :specificHiddenTreasures, :specificVisibleTreasures
  private_class_method :new
end
