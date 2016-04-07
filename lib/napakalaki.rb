#encoding: utf-8
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'treasure_kind.rb'
require_relative 'bad_consequence.rb'
require 'singleton'

class Napakalaki
  
  include Singleton
  
  #@currentPlayerIndex=0
  #@currentMonster
  #@dealer=CardDealer.instance
  #@currentPlayer
  #@players
  
  public  
    def developCombat

    end

    def discardVisibleTreasures treasures

    end

    def discardHiddenTreasures treasures

    end

    def makeTreasuresVisible treasures

    end

    def initGame players

    end

    def getCurrentPlayer

    end

    def getCurrentMonster

    end

    def nextTurn

    end

    def endOfGame result

    end
  
  private
  
    def initPlayers names
      
    end
    
    def nextPlayer
      
    end
    
    def nextTurnAllowed
      
    end
    
end
