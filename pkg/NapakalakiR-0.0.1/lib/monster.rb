#encoding: utf-8
require_relative 'prize.rb'
require_relative 'treasure.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'treasure_kind.rb'
require_relative 'bad_consequence.rb'

module NapakalakiGame
  class Monster
    def initialize(name, lvl, bc, prize, lC)
      @name=name
      @level=lvl
      @bc=bc
      @prize=prize
      @levelChangeAgainstCultistPlayer = lC
    end

    attr_reader :name, :level, :bc, :prize

    def getCombatLevelAgainstCultistPlayer
      @level+@levelChangeAgainstCultistPlayer
    end
    
    def getLevelsGained
      @prize.levels
    end

    def getTreasuresGained
      @prize.treasures
    end

    def getCombatLevel
      @level
    end

    def to_s
      "Nombre : "+@name+
        "\nNivel de combate: "+@level.to_s+
        "\nNivel de combate contra cultist: "+ getCombatLevelAgainstCultistPlayer.to_s +
        "\nBuen rollo: "+@prize.to_s+
        "\nMal rollo : "+@bc.to_s+"\n"
    end
  end
end
