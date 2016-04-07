#encoding: utf-8
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'treasure_kind.rb'
require_relative 'bad_consequence.rb'

class Player
  #@name
  #@level
  #@dead
  #@pendingBadConsequence
  #@visibleTreasures
  #@hiddenTreasures
  @@MAXLEVEL=10
  
  def self.MAXlevel
    @@MAXLEVEL
  end
  
  attr_reader :name, :visibleTreasures, :hiddenTreasures, :level
  
  public
    def initialize name
      @name=name
    end
      
    def isDead
      @dead
    end
    
    def combat m
      
    end
    
    def makeTreasureVisible t
      
    end
    
    def discardVisibleTreasure t
      
    end
    
    def discardHiddenTreasure t
      
    end
    
    def validState
      @pendigBadConsequence.isEmpty && 
        @hiddenTreasures.length <= 4
    end
    
    def iniTreasures
      
    end
    
    def discardAllTreasures
      
    end
    
  private
  
    def bringToLife
      @dead = false
    end
    
    def getCombatLevel
      lvl=@level
      @visibleTreasures.each do |i|
        lvl += + i.bonus
      end
      lvl
    end

    def incrementLevels l
      @level+=l
    end

    def decrementLevels l
      if l >= @level
        @level=1
      else
        level -=l
      end
    end

    def setPendingBadConsequence b
      @pendingBadConsequence = b
    end

    def applyPrize m
      
    end 

    def applyBadConsequence m
      
    end

    def canMakeTreasureVisible t
      
    end 

    def howManyVisibleTreasures tKind
      count=0
      @visibleTreasures.each do |i|
        if i.type == tKind
          count+=1;
        end
      end
      count
    end

    def dieIfNoTreasures
      if @hiddenTreasures.empty? && @visibleTreasures.empty?
        @dead=true
        @level=1
      end
    end

end
