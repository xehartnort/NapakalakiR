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

    def initialize(text, lvl)
      @textoIntroduccion = "\n\tEsto es un mal rollo con el siguiente contenido:"
      @text=text
      @levels=lvl
    end

    def self.MAXtreasures
      @@MAXTREASURES
    end

    private_class_method :new

    attr_reader :text, :levels, :textoIntroduccion
    
    def substractHiddenTreasure t
      raise NotImplementedError.new
    end

    def substractHiddenTreasure t 
      raise NotImplementedError.new
    end
    
    def isEmpty
      raise NotImplementedError.new
    end

    def adjustToFitTreasureLists v, h #v:Treasure[], h:Treasure[]
      raise NotImplementedError.new
    end

    def to_s
      raise NotImplementedError.new
    end
    
  end
end
