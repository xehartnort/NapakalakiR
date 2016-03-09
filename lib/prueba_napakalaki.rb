#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'bad_consequence.rb'
require_relative 'treasure_kind.rb'
require_relative 'monster.rb'
require_relative 'prize.rb'
#Main for testing
if __FILE__ == $0
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
    
    #El gorron en el umbral
    bc = BadConsequence.newLevelNumberOfTreasures("Pierdes todos tus tesoros"+ 
    "visibles", 0, 10,0)
    p = Prize.new(3,1)
    monstruos << Monster.new("El gorron en el umbral", 10, bc, p)
    
    #HP Munchcraft
    bc = BadConsequence.newLevelSpecificTreasures("Pierdes la armadura visible",
    0,[TreasureKind::ARMOR], Array.new)
    p = Prize.new(2,1)
    monstruos << Monster.new("HP Munchcraft", 6, bc, p)
    
    #Bichgooth
    bc = BadConsequence.newLevelSpecificTreasures("Sientes bichos bajo la ropa."+ 
    "Descarta la armadura visible.",0, [TreasureKind::ARMOR], Array.new)
    p = Prize.new(1,1)
    monstruos << Monster.new("Bichgooth", 2, bc, p)
    
    #El rey de rosa
    bc = BadConsequence.newLevelNumberOfTreasures("Pierdes 5 niveles y "+
    "3 tesoros visibles",5,3,0)
    p = Prize.new(4,2)
    monstruos << Monster.new("El rey de rosa", 13, bc, p)
   
    #La que redacta en las tinieblas
    bc = BadConsequence.newLevelNumberOfTreasures("Toses los pulmones y " + 
    "pierdes dos niveles",2,0,0)
    p = Prize.new(1,1)
    monstruos << Monster.new("La que redacta en las tinieblas", 2, bc, p)
    
    #Los hondos
    bc = BadConsequence.newDeath("Estos monstruos resultan bastante superficiales " +
    "aburren mortalmente. Estas muerto.")
    p = Prize.new(2,1)
    monstruos << Monster.new("Los hondos", 8, bc, p)
    
    #Semillas Cthulhu
    bc = BadConsequence.newLevelNumberOfTreasures("Pierdes 2 niveles y " + 
    "2 tesoros ocultos",2,0,2)
    p = Prize.new(2,1)
    monstruos << Monster.new("Semillas Cthulhu", 4, bc, p)
    
    #Dameargo
    bc = BadConsequence.newLevelSpecificTreasures("Te intentas escaquear." +
    "Pierdes una mano visible",0,[TreasureKind::ONEHAND], Array.new)
    p = Prize.new(2,1)
    monstruos << Monster.new("Dameargo", 1, bc, p)
    
    #Pollipolipo volante
    bc = BadConsequence.newLevelNumberOfTreasures("Da mucho asquito. Pierdes"+ 
    " 3 niveles", 3, 0,0)
    p = Prize.new(1,1)
    monstruos << Monster.new("Pollipolipo volante", 3, bc, p)
    
    #Yskhtihyssg-Goth
    bc = BadConsequence.newDeath("No le hace gracia que pronuncien mal su " +
    "nombre. Estas muerto.")
    p = Prize.new(3,1)
    monstruos << Monster.new("Yskhtihyssg-Goth", 12, bc, p)
    
    #Familia feliz
    bc = BadConsequence.newDeath("La familia te atrapa. Estás muerto.")
    p = Prize.new(4,1)
    monstruos << Monster.new("Familia feliz", 1, bc, p)
    
    #Roboggoth
    bc = BadConsequence.newLevelSpecificTreasures("La quinta directiva " + 
    "primaria te obliga a perder 2 niveles y un tesoro 2 manos visible.", 2,
    [TreasureKind::BOTHHANDS], Array.new)
    p = Prize.new(2,1)
    monstruos << Monster.new("Roboggoth", 8, bc, p)
    
    #El espia
    bc = BadConsequence.newLevelSpecificTreasures("Te asusta en la noche. " +
    "Pierdes un casco visible.", 0,[TreasureKind::HELMET], Array.new)
    p = Prize.new(1,1)
    monstruos << Monster.new("El espia", 5, bc, p)
    
    #El lenguas
    bc = BadConsequence.newLevelNumberOfTreasures("Menudo susto te llevas."+
    " Pierdes 2 niveles y 5 tesoros visibles.",2,5,0)
    p = Prize.new(1,1)
    monstruos << Monster.new("El lenguas", 20, bc, p)
    
    #Bicefalo
    bc = BadConsequence.newLevelSpecificTreasures("Te faltan manos para tanta"+ 
    "cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos", 3,
    [TreasureKind::ONEHAND,TreasureKind::ONEHAND,TreasureKind::BOTHHANDS],
    Array.new)
    p = Prize.new(1,1)
    monstruos << Monster.new("Bicefalo", 20, bc, p)
  
  puts "\nNivel de combate superior a 10\n"
  monstruos.each{ |x|
    if x.level > 10
      puts x.to_s
    end
  }
  puts "\nMal rollo sólo pérdida niveles\n"
  monstruos.each{ |x|
    if x.bc.specificHiddenTreasures.empty? &&
        x.bc.specificVisibleTreasures.empty? &&
        (( x.bc.nHiddenTreasures==10 && x.bc.nVisibleTreasures==10 ) ||
          x.bc.nHiddenTreasures==0 && x.bc.nVisibleTreasures==0)
      puts x.to_s
    end
  }
  puts "\nSu buen rollo indique una ganancia de niveles superior a 1\n"
  monstruos.each{ |x|
    if x.prize.level > 1
      puts x.to_s
    end 
  }
  puts "\nSu mal rollo suponga la pérdida de un determinado tipo de tesoros ya sea visibles\n" +
"y/o ocultos\n"
  monstruos.each{ |x|
    if !( x.bc.specificHiddenTreasures.empty? &&
         x.bc.specificVisibleTreasures.empty?)
      puts x.to_s
    end
    
  }
    
  
  
end