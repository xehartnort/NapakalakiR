#encoding: utf-8
require_relative 'prize.rb'
require_relative 'player.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'treasure_kind.rb'
module NapakalakiGame
  class BadConsequence
    @@MAXTREASURES=10

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

    def self.MAXtreasures
      @@MAXTREASURES
    end

    private_class_method :new

    attr_reader :text, :levels, :nHiddenTreasures, :nVisibleTreasures, 
        :specificHiddenTreasures, :specificVisibleTreasures

    def isEmpty
      (@nHiddenTreasures+@nVisibleTreasures)==0 &&
        @specificHiddenTreasures.empty? &&
        @specificVisibleTreasures.empty?
    end

    def substractVisibleTreasure t
      if @specificVisibleTreasures.include?(t.type)
        i = @specificVisibleTreasures.find_index(t.type)
        @specificVisibleTreasures.delete_at(i)
      else
        @nVisibleTreasures = (@nVisibleTreasures-1) < 0 ? 0 : @nVisibleTreasures-1 ;
      end
    end

    def substractHiddenTreasure t
      if @specificHiddenTreasures.include?(t.type)
        i = @specificHiddenTreasures.find_index(t.type)
        @specificHiddenTreasures.delete_at(i)
      else
        @nHiddenTreasures = (@nHiddenTreasures-1) < 0 ? 0 : @nHiddenTreasures-1 ;
      end
    end
   
   def adjustToFitTreasureLists v, h #v:Treasure[], h:Treasure[]
      if !@specificVisibleTreasures.empty? || !@specificHiddenTreasures.empty?
        newVisibleTreasuresBad = Array.new
        newHiddenTreasuresBad = Array.new
        copyOfspecificVisibleTreasures = @specificVisibleTreasures.clone
        copyOfspecificHiddenTreasures = @specificHiddenTreasures.clone

        v.each do |t|
          if copyOfspecificVisibleTreasures.include? t.type
            index = copyOfspecificVisibleTreasures.index(t.type)
            copyOfspecificVisibleTreasures.delete_at(index)
            newVisibleTreasuresBad << t.type
          end
        end

        h.each do |t|
          if copyOfspecificHiddenTreasures.include? t.type
            index = copyOfspecificHiddenTreasures.index(t.type)
            copyOfspecificHiddenTreasures.delete_at(index)
            newHiddenTreasuresBad << t.type
          end
        end
        BadConsequence.newLevelSpecificTreasures(@text, 0, newVisibleTreasuresBad, newHiddenTreasuresBad) #return
      else
  #     Número de tesoros visibles a quitar 
        minVisibleTreasures =  @nVisibleTreasures > v.length ? v.length : @nVisibleTreasures
  #      Número de tesoros ocultos a quitar
        minHiddenTreasures = @nHiddenTreasures > h.length ? h.length : @nHiddenTreasures
        BadConsequence.newLevelNumberOfTreasures(@text, 0, minVisibleTreasures, minHiddenTreasures) #return
      end
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
                    "Visibles: "+@nVisibleTreasures.to_s
        else
          "Nivel: "+@levels.to_s+"\n"+
                    "Descripcion: "+@text+"\n"+
                    "Mal rollo quita tesoros especificos\n Ocultos: "+
                    @specificHiddenTreasures.to_s + "\n Visibles: "+
                    @specificVisibleTreasures.to_s
        end
      end
    end
  end
end
