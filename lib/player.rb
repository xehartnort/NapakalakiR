#encoding: utf-8
require_relative 'prize.rb'
require_relative 'combat_result.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'treasure_kind.rb'
require_relative 'bad_consequence.rb'

module NapakalakiGame

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

    attr_reader :level

    public

      def initialize name
        @dealer = CardDealer.instance
        @name=name
        @level=1
        @hiddenTreasures=Array.new
        @visibleTreasures=Array.new
        @pendingBadConsequence = BadConsequence.newLevelNumberOfTreasures("Vacio", 0, 0, 0)
        @dead=true
      end

      def getName
        @name
      end

      def getVisibleTreasures
        @visibleTreasures
      end

      def getHiddenTreasures
        @hiddenTreasures
      end

      def getPendingBadConsequence
        @pendingBadConsequence
      end

      def isDead
        @dead
      end

      def combat m # return CombatResult
        myLevel = getCombatLevel
        monsterLevel = m.getCombatLevel
        if myLevel > monsterLevel
          applyPrize(m)
          if @level >= @@MAXLEVEL
            combatResult = CombatResult::WINGAME
          else
            combatResult = CombatResult::WIN
          end
        else
          applyBadConsequence(m)
          combatResult = CombatResult::LOSE
        end
        combatResult
      end

      def makeTreasureVisible t
        canI = canMakeTreasureVisible(t)
        if canI
          @visibleTreasures << t
          @hiddenTreasures.delete(t)
        end
      end

      def discardVisibleTreasure t
        @visibleTreasures.delete(t)
        @dealer.giveTreasureBack(t)
        if @pendingBadConsequence!=nil && !@pendingBadConsequence.isEmpty
          @pendingBadConsequence.substractVisibleTreasure(t)
        end
        dieIfNoTreasures
      end

      def discardHiddenTreasure t
        @hiddenTreasures.delete(t)
        @dealer.giveTreasureBack(t)
        if @pendingBadConsequence!=nil && !@pendingBadConsequence.isEmpty
          @pendingBadConsequence.substractHiddenTreasure(t)
        end
        dieIfNoTreasures
      end

      def validState
        @pendingBadConsequence.isEmpty && 
          @hiddenTreasures.length <= 4
      end

      def initTreasures
        dice = Dice.instance
        bringToLife
        treasure = @dealer.nextTreasure
        @hiddenTreasures << treasure
        number = dice.nextNumber
        if number > 1
          treasure = @dealer.nextTreasure
          @hiddenTreasures << treasure
        end
        if number == 6
          treasure = @dealer.nextTreasure
          @hiddenTreasures << treasure
        end
      end

      def discardAllTreasures
        clon1 = @visibleTreasures.clone
        clon2 = @hiddenTreasures.clone
        clon1.each do |t|
          discardVisibleTreasure(t)
        end
        clon2.each do |t|
          discardHiddenTreasure(t)
        end
      end

      def to_s
        text = "\n\tName = " + @name.to_s+
              "\n\tLevel = " + @level.to_s + 
              "\n\tPendingBadConsequence: { " + @pendingBadConsequence.to_s + "\n\t} "+
              "\n\tDead = " + @dead.to_s +
              "\n\tCombatLevel =" + getCombatLevel.to_s
        textoHiddenTreasures = " \n\tArray Hidden Treasures: { "
        textoVisibleTreasures = " \n\tArray Visible Treasures: { "
        unless @visibleTreasures.empty?
          @visibleTreasures.each do |t|
            textoVisibleTreasures += t.to_s + " "
          end 
        else
          textoVisibleTreasures += "No tiene ningún tesoro visible. "
        end

        unless @hiddenTreasures.empty?
          @hiddenTreasures.each do |t|
            textoHiddenTreasures += t.to_s + " "
          end 
        else
          textoHiddenTreasures += "No tiene ningún tesoro oculto. "
        end
        text += textoHiddenTreasures + "}" + textoVisibleTreasures + "}" #return
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
          @level -= l
        end
      end

      def setPendingBadConsequence b
        @pendingBadConsequence = b
      end

      def applyPrize m
        nLevels = m.getLevelsGained
        incrementLevels(nLevels)
        nTreasures = m.getTreasuresGained
        if nTreasures > 0
          for i in 1..nTreasures
            treasure = @dealer.nextTreasure
            @hiddenTreasures << treasure
          end
        end
      end 

      def applyBadConsequence m
        badConsequence = m.bc
        nLevels = badConsequence.levels
        decrementLevels(nLevels)
        pendingBad = badConsequence.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures)
        setPendingBadConsequence(pendingBad)
      end

      def canMakeTreasureVisible t
        @visibleTreasures << t #inserta al final del array el objeto t
        canI = true
        valido = Array.new(5, false) # array de 5 componentes, todas a false
        @visibleTreasures.each do |i|
          case i.type
            when TreasureKind::ARMOR
              if valido[0]
                canI = false
              else
                valido[0] = true
              end
           when TreasureKind::HELMET
              if valido[1]
                canI = false
              else
                valido[1] = true
              end
            when TreasureKind::BOTHHANDS
              if valido[2] || valido[3]
                canI = false
              else 
                valido[2] = true
                valido[3] = true
              end
            when TreasureKind::ONEHAND
              if valido[2]
                if valido[3]
                  canI = false
                else
                  valido[3] = true
                end
              else
                valido[2] = true
              end
            else #when TreasureKind::SHOES
              if valido[4]
                canI = true
              else
                valido[4] = true
              end
          end
        end
        @visibleTreasures.pop # borra el último añadido
        canI  #return
      end 

      def howManyVisibleTreasures tKind
        count = 0
        @visibleTreasures.each do |i|
          if i.type == tKind
            count += 1;
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
end