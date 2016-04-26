#encoding: utf-8
require_relative 'prize.rb'
require_relative 'combat_result.rb'
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
  @@contador=0
  
  def self.MAXlevel
    @@MAXLEVEL
  end
  
  attr_reader :name, :level
  
  public
  
    def initialize name
      @dealer = CardDealer.instance
      @name=name
      @level=1
      @hiddenTreasures=Array.new
      @visibleTreasures=Array.new
      @dead=true
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
      canI = canMakeTreasueVisible(t)
      if canI
        @visibleTreasures << t
        @hiddenTreasures.delete(t)
      end
    end
    
    def discardVisibleTreasure t
      @visibleTreasures.delete(t)
      @dealer.giveTreasureBack(t)
      if @pendingBadConsequence!=nill && !@pendingBadConsequence.isEmpty
        @pendingBadConsequence.substractVisibleTreasure(t)
      end
      dieIfNoTreasures
    end
    
    def discardHiddenTreasure t
      @hiddenTreasures.delete(t)
      @dealer.giveTreasureBack(t)
      if @pendingBadConsequence!=nill && !@pendingBadConsequence.isEmpty
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
      @visibleTreasures.each do |t|
        discardVisibleTreasure(t)
      end
      @hiddenTreasures.each do |t|
        discardHiddenTreasure(t)
      end
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
