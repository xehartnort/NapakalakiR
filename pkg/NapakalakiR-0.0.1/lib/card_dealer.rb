#encoding: utf-8
require_relative 'bad_consequence.rb'
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'treasure_kind.rb'
require_relative 'player.rb'
require 'singleton'

module NapakalakiGame

  class CardDealer

    include Singleton

    #@usedMonsters
    #@unusedMonsters
    #@unusedTreasures
    #@usedTreasures

    public

      def nextTreasure
        if @unusedTreasures.empty?
          @usedTreasures.shuffle!
          @unusedTreasures = @usedTreasures.clone # copia a un nivel
          @usedTreasures.clear
        end
          treasure = @unusedTreasures.pop
          @usedTreasures << treasure
          treasure #return
      end

      def nextMonster
        if @unusedMonsters.empty?
          @usedMonsters.shuffle!
          @unusedMonsters = @usedMonsters.clone # copia a un nivel
          @usedMonsters.clear
        end
          treasure = @unusedMonsters.pop
          @usedMonsters << treasure
          treasure #return
      end
      #EXAMEN
      def getRandomMonster
        if @unusedMonsters.empty?
          m = nil
        else
          m = @unusedMonsters[ rand(@unusedMonsters.size) ]
          @unusedMonsters.delete(m)
          @usedMonsters << m
        end
        m
      end
      #FIN EXAMEN

      def giveTreasureBack t 
        @usedTreasures << t
        @unusedTreasures.delete(t)
      end

      def giveMonsterBack m
        @usedMonsters << m
        @unusedMonsters.delete(m)
      end

      def initCards
        initMonsterCardDeck
        initTreasureCardDeck
        shuffleMonsters
        shuffleTreasures
      end

    private

      def initTreasureCardDeck
        @usedTreasures = Array.new
        @unusedTreasures = Array.new
        @unusedTreasures<< Treasure.new("¡Sí mi amo!", 4, TreasureKind::HELMET)
        @unusedTreasures<< Treasure.new("Botas de investigación", 3, TreasureKind::SHOES)
        @unusedTreasures<< Treasure.new("Capucha de Cthulhu", 3, TreasureKind::HELMET)
        @unusedTreasures<< Treasure.new("A prueba de babas", 2, TreasureKind::ARMOR)
        @unusedTreasures<< Treasure.new("Botas de lluvia ácida", 1, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Casco minero", 2, TreasureKind::HELMET)
        @unusedTreasures<< Treasure.new("Ametralladora Thompson", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Camiseta de la UGR", 1, TreasureKind::ARMOR)
        @unusedTreasures<< Treasure.new("Clavo de rail ferroviario", 3, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Cuchillo de sushi arcano", 2, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Fez alópodo", 3, TreasureKind::HELMET)
        @unusedTreasures<< Treasure.new("Hacha prehistórica", 2, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("El aparato del Pr. Tesla", 4, TreasureKind::ARMOR)
        @unusedTreasures<< Treasure.new("Gaita", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Insecticida", 2, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Escopeta de 3 cañones", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Garabato místico", 2, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("La rebeca metálica", 2, TreasureKind::ARMOR)
        @unusedTreasures<< Treasure.new("Mazo de los antiguos", 3, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Necro-playboycon", 3, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Lanzallamas", 4, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Necro-comicón", 1, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Necronomicón", 5, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Linterna a 2 manos", 3, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Necro-gnomicón", 2, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Necrotelecom", 2, TreasureKind::HELMET)
        @unusedTreasures<< Treasure.new("Porra preternatural", 2, TreasureKind::ONEHAND)
        @unusedTreasures<< Treasure.new("Tentácula de pega", 2, TreasureKind::HELMET)
        @unusedTreasures<< Treasure.new("Zapato deja-amigos", 1, TreasureKind::SHOES)
        @unusedTreasures<< Treasure.new("Shogulador", 1, TreasureKind::BOTHHANDS)
        @unusedTreasures<< Treasure.new("Varita de atizamiento", 3, TreasureKind::ONEHAND)

      end

      def initMonsterCardDeck
        @usedMonsters = Array.new
        @unusedMonsters = Array.new

        #3 byakhees de bonanza
        bc = BadConsequence.newLevelSpecificTreasures("Pierdes tu armadura visible"+ 
        "y otra oculta", 0,[TreasureKind::ARMOR], [TreasureKind::ARMOR])
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("3 byakhees de bonanza", 8, bc, p)

        #Chibithulhu
        bc = BadConsequence.newLevelSpecificTreasures("Embobados con el lindo" +
        " primigenio te descartas de tu casco visible",0,[TreasureKind::HELMET], 
        Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Chibithulhu", 2, bc, p)

        #El sopor de Dunwich
        bc = BadConsequence.newLevelSpecificTreasures("El primordial bostezo " + 
        "contagioso. Pierdes el calzado visible.", 0,[TreasureKind::SHOES], 
        Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("El sopor de Dunwich", 2, bc, p)

        #Angeles de la noche ibicenca
        bc = BadConsequence.newLevelSpecificTreasures("Te atrapan para llevarte " +
        "de fiesta y te dejan caer en mitad del vuelo. Descarte 1 mano visible y" +
        " 1 mano oculta.",0,[TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
        p = Prize.new(4,1)
        @unusedMonsters << Monster.new("Angeles de la noche ibicenca", 14, bc, p)

        #El gorron en el umbral
        bc = BadConsequence.newLevelNumberOfTreasures("Pierdes todos tus tesoros"+ 
        "visibles", 0, BadConsequence.MAXtreasures,0)
        p = Prize.new(3,1)
        @unusedMonsters << Monster.new("El gorron en el umbral", Player.MAXlevel, bc, p)

        #HP Munchcraft
        bc = BadConsequence.newLevelSpecificTreasures("Pierdes la armadura visible",
        0,[TreasureKind::ARMOR], Array.new)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("HP Munchcraft", 6, bc, p)

        #Bichgooth
        bc = BadConsequence.newLevelSpecificTreasures("Sientes bichos bajo la ropa."+ 
        "Descarta la armadura visible.",0, [TreasureKind::ARMOR], Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Bichgooth", 2, bc, p)

        #El rey de rosa
        bc = BadConsequence.newLevelNumberOfTreasures("Pierdes 5 niveles y "+
        "3 tesoros visibles",5,3,0)
        p = Prize.new(4,2)
        @unusedMonsters << Monster.new("El rey de rosa", 13, bc, p)

        #La que redacta en las tinieblas
        bc = BadConsequence.newLevelNumberOfTreasures("Toses los pulmones y " + 
        "pierdes dos niveles",2,0,0)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("La que redacta en las tinieblas", 2, bc, p)

        #Los hondos
        bc = BadConsequence.newDeath("Estos monstruos resultan bastante superficiales " +
        "aburren mortalmente. Estas muerto.")
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Los hondos", 8, bc, p)

        #Semillas Cthulhu
        bc = BadConsequence.newLevelNumberOfTreasures("Pierdes 2 niveles y " + 
        "2 tesoros ocultos",2,0,2)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Semillas Cthulhu", 4, bc, p)

        #Dameargo
        bc = BadConsequence.newLevelSpecificTreasures("Te intentas escaquear." +
        "Pierdes una mano visible",0,[TreasureKind::ONEHAND], Array.new)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Dameargo", 1, bc, p)

        #Pollipolipo volante
        bc = BadConsequence.newLevelNumberOfTreasures("Da mucho asquito. Pierdes"+ 
        " 3 niveles", 3, 0,0)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Pollipolipo volante", 3, bc, p)

        #Yskhtihyssg-Goth
        bc = BadConsequence.newDeath("No le hace gracia que pronuncien mal su " +
        "nombre. Estas muerto.")
        p = Prize.new(3,1)
        @unusedMonsters << Monster.new("Yskhtihyssg-Goth", 12, bc, p)

        #Familia feliz
        bc = BadConsequence.newDeath("La familia te atrapa. Estás muerto.")
        p = Prize.new(4,1)
        @unusedMonsters << Monster.new("Familia feliz", 1, bc, p)

        #Roboggoth
        bc = BadConsequence.newLevelSpecificTreasures("La quinta directiva " + 
        "primaria te obliga a perder 2 niveles y un tesoro 2 manos visible.", 2,
        [TreasureKind::BOTHHANDS], Array.new)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Roboggoth", 8, bc, p)

        #El espia
        bc = BadConsequence.newLevelSpecificTreasures("Te asusta en la noche. " +
        "Pierdes un casco visible.", 0,[TreasureKind::HELMET], Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("El espia", 5, bc, p)

        #El lenguas
        bc = BadConsequence.newLevelNumberOfTreasures("Menudo susto te llevas."+
        " Pierdes 2 niveles y 5 tesoros visibles.",2,5,0)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("El lenguas", 20, bc, p)

        #Bicefalo
        bc = BadConsequence.newLevelSpecificTreasures("Te faltan manos para tanta"+ 
        "cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos", 3,
        [TreasureKind::ONEHAND,TreasureKind::ONEHAND,TreasureKind::BOTHHANDS],
        Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Bicefalo", 20, bc, p)
      end

      def shuffleTreasures
        @unusedTreasures.shuffle!
      end

      def shuffleMonsters
        @unusedMonsters.shuffle!
      end

  end
end