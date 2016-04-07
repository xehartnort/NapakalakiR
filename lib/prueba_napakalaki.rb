#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'bad_consequence.rb'
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'treasure_kind.rb'
require_relative 'card_dealer.rb'
require_relative 'player.rb'


## PRUEBA CARD DEALER
dealer = CardDealer.instance
dealer.initCards

badConsequence =BadConsequence.newLevelSpecificTreasures("El primordial bostezo contaguioso." +
          "Pierdes el calzado visible",0,[TreasureKind::HELMET],Array.new)
prize = Prize.new(1,1)
m=Monster.new("El sopor de Dunwich", 2, badConsequence, prize)

dealer.giveMonsterBack(m)
dealer.giveTreasureBack(Treasure.new("¡Sí mi amo!", 4,TreasureKind::HELMET))


## PRUBEA DICE
#dice=Dice.instance
#
#for i in 1..10
#  puts dice.nextNumber
#end

## PRUEBA MONSTER

#badConsequence =BadConsequence.newLevelSpecificTreasures("Pierdes tu armadura visible y" +
#          "otra oculta",0,[TreasureKind::ARMOR],[TreasureKind::ARMOR])
#prize = Prize.new(2, 1)
#monster=Monster.new("3 Byakhees de bonanza", 8, badConsequence, prize)
#
#puts monster.getLevelsGained
#puts monster.getTreasuresGained
#puts monster.to_s


## PRUEBA PIZE
#pc = Prize.new(1,1)
#puts pc.levels
#puts pc.treasures
#puts pc.to_s


## PRUEBA TREASURE
#t = Treasure.new("t1",10,TreasureKind::ARMOR)
#puts t.name
#puts t.bonus
#puts t.type


## PRUEBA BAD CONSEQUENCE
#array= Array.new
#array << TreasureKind::ONEHAND
#
# bc1 = BadConsequence.newDeath("muerte")
# bc2 = BadConsequence.newLevelNumberOfTreasures("num",1,1,1)
# bc3 = BadConsequence.newLevelSpecificTreasures("esp",1,[TreasureKind::ONEHAND,TreasureKind::ONEHAND],Array.new)
# bc4 = BadConsequence.newLevelNumberOfTreasures("vacio",0,0,0)
# 
#puts bc1.to_s
#puts bc2.to_s
#puts bc3.to_s
#puts bc4.to_s
#
#puts bc3.isEmpty
#puts bc4.isEmpty

## PRUEBA PLAYER
#player = Player.new("p1")
#puts player.isDead
#player.bringToLife
#puts player.isDead
#player.dieIfNoTreasures
#puts player.isDead
#puts player.level
#player.incrementLevels(1)
#puts player.level
#player.decrementLevels(3)
#puts player.level
#puts player.getCombatLevel

## PRUEBA NAPAKALAKI
