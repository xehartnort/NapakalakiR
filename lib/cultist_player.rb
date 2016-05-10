#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module NapakalakiGame
  class CultistPlayer < Player
    
    @@totalCultistPlayers=0
    
    def initialize p, c # Player, Cultist
      super(p.getName, p.level, 
        p.isDead, p.getVisibleTreasures, 
        p.getHiddenTreasures, p.getPendingBadConsequence)
      @myCultistCard=c
      @@totalCultistPlayers+=1
    end
    
    public
        
      def self.getTotalCultistPlayers
        @@totalCultistPlayers
      end
      
    protected
    
      def getCombatLevel
        (1.5 * super + @myCultistCard.getGainedLevels * @@totalCultistPlayers).to_i
      end
      
      def getOponentLevel m
        m.getCombatLevelAgainstCultistPlayer
      end
      
      def shouldConvert
        false
      end
  end
end
