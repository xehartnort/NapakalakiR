#encoding: utf-8
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'player.rb'
require_relative 'cultist_player.rb'
require_relative 'treasure.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'treasure_kind.rb'
require_relative 'bad_consequence.rb'
require_relative 'combat_result.rb'
require 'singleton'

module NapakalakiGame

  class Napakalaki
  
    include Singleton

    def initialize
      @currentPlayerIndex=-1
      @players=Array.new
      @dealer=CardDealer.instance
    end

    public  
      def developCombat
        combatResult = @currentPlayer.combat(@currentMonster)
        @dealer.giveMonsterBack(@currentMonster)
        if combatResult == CombatResult::LOSEANDCONVERT
          jugador = CultistPlayer.new(@currentPlayer, @dealer.nextCultist)
          @currentPlayer = jugador
          @players[@currentPlayerIndex] = jugador
        end
        combatResult
      end

      def discardVisibleTreasures treasures
        treasures.each do |t|
          @currentPlayer.discardVisibleTreasure(t)
        end
      end

      def discardHiddenTreasures treasures
        treasures.each do |t|
          @currentPlayer.discardHiddenTreasure(t)
        end
      end

      def makeTreasuresVisible treasures
        treasures.each do |t|
          @currentPlayer.makeTreasureVisible(t)
        end
      end

      def initGame players
        initPlayers(players)
        @dealer.initCards
        nextTurn
      end

      def getCurrentPlayer
         @currentPlayer
      end

      def getCurrentMonster
         @currentMonster
      end

      def nextTurn
        stateOK = nextTurnAllowed
        if stateOK
          @currentMonster = @dealer.nextMonster
          @currentPlayer = nextPlayer
          if @currentPlayer.isDead
            @currentPlayer.initTreasures
          end
        end
        stateOK
      end

      def endOfGame result
        result == CombatResult::WINGAME
      end

    private

      def initPlayers names
        names.each do |n|
            @players << Player.new(n)
        end
      end

      def nextPlayer
        if @currentPlayerIndex == -1 # primera jugada
          @currentPlayerIndex = Dice.instance.nextNumber % @players.size
        else
          @currentPlayerIndex = (@currentPlayerIndex+1)%@players.size
        end
        @players[@currentPlayerIndex] #return
      end

      def nextTurnAllowed
        if @currentPlayer == nil # en la primera jugada siempre deja pasar de turno
          turno = true
        else
          turno = @currentPlayer.validState 
        end
        turno
      end

  end
end