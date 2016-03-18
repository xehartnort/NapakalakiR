#encoding: utf-8
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'statistics.rb'
require_relative 'bad_consequence.rb'
require_relative 'treasure_kind.rb'
require_relative 'monster.rb'
require_relative 'prize.rb'

module EX1
  
  class ExamenViernes18
    def self.principal(monster)
      obj= EX2::Statistics.new
      obj.compute(monster)
    end
  end


if __FILE__ == $0
    puts "hola"
    monstruos = Array.new
    #3 byakhees de bonanza
    bc = BadConsequence.newLevelSpecificTreasures("Pierdes tu armadura visible"+ 
    "y otra oculta", 0,[TreasureKind::ARMOR], [TreasureKind::ARMOR])
    p = Prize.new(2,1)
    monstruos << Monster.new("3 byakhees de bonanza", 8, bc, p)
    
    #Chibithulhu
    bc = BadConsequence.newLevelSpecificTreasures("Embobados con el lindo" +
    " primigenio te descartas de tu casco visible",0,[TreasureKind::HELMET], 
    Array.new)
    p = Prize.new(1,1)
    monstruos << Monster.new("Chibithulhu", 2, bc, p)
    
    #El sopor de Dunwich
    bc = BadConsequence.newLevelSpecificTreasures("El primordial bostezo " + 
    "contagioso. Pierdes el calzado visible.", 0,[TreasureKind::SHOES], 
    Array.new)
    p = Prize.new(1,1)
    monstruos << Monster.new("El sopor de Dunwich", 2, bc, p)
    
    #Angeles de la noche ibicenca
    bc = BadConsequence.newLevelSpecificTreasures("Te atrapan para llevarte " +
    "de fiesta y te dejan caer en mitad del vuelo. Descarte 1 mano visible y" +
    " 1 mano oculta.",0,[TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
    p = Prize.new(4,1)
    monstruos << Monster.new("Angeles de la noche ibicenca", 14, bc, p)
    
    ExamenViernes18.principal(monstruos)
end
end
