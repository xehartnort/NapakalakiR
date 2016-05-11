#encoding: utf-8
require_relative 'numeric_bad_consequence.rb'
require_relative 'specific_bad_consequence.rb'
require_relative 'death_bad_consequence.rb'
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'treasure_kind.rb'
require_relative 'player.rb'
require_relative 'cultist.rb'
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
          monster = @unusedMonsters.pop
          @usedMonsters << monster
          monster #return
      end

      def nextCultist
          cultist = @unusedCultists.pop
          cultist #return
      end

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
        initCultistCardDeck
        shuffleMonsters
        shuffleTreasures
        shuffleCultists
      end

    private

      def initCultistCardDeck
#        @usedCultists = Array.new
        @unusedCultists = Array.new
        @unusedCultists << Cultist.new("Agaricus", 1)
        @unusedCultists << Cultist.new("Boletus", 2)
        @unusedCultists << Cultist.new("Daldinia", 1)
        @unusedCultists << Cultist.new("Bolbitius", 2)
        @unusedCultists << Cultist.new("Calvatia", 1)
        @unusedCultists << Cultist.new("Dermoloma", 1)
      end
      
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
        bc = SpecificBadConsequence.new("Pierdes tu armadura visible"+ 
        "y otra oculta", 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("3 byakhees de bonanza", 8, bc, p, 0)

        #Chibithulhu
        bc = SpecificBadConsequence.new("Embobados con el lindo" +
        " primigenio te descartas de tu casco visible",0,[TreasureKind::HELMET], 
        Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Chibithulhu", 2, bc, p, 0)

        #El sopor de Dunwich
        bc = SpecificBadConsequence.new("El primordial bostezo " + 
        "contagioso. Pierdes el calzado visible.", 0,[TreasureKind::SHOES], 
        Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("El sopor de Dunwich", 2, bc, p, 0)

        #Angeles de la noche ibicenca
        bc = SpecificBadConsequence.new("Te atrapan para llevarte " +
        "de fiesta y te dejan caer en mitad del vuelo. Descarte 1 mano visible y" +
        " 1 mano oculta.",0,[TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
        p = Prize.new(4,1)
        @unusedMonsters << Monster.new("Angeles de la noche ibicenca", 14, bc, p, 0)

        #El gorron en el umbral
        bc = NumericBadConsequence.new("Pierdes todos tus tesoros"+ 
        "visibles", 0, BadConsequence.MAXtreasures,0)
        p = Prize.new(3,1)
        @unusedMonsters << Monster.new("El gorron en el umbral", Player.MAXlevel, bc, p, 0)

        #HP Munchcraft
        bc = SpecificBadConsequence.new("Pierdes la armadura visible",
        0,[TreasureKind::ARMOR], Array.new)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("HP Munchcraft", 6, bc, p, 0)

        #Bichgooth
        bc = SpecificBadConsequence.new("Sientes bichos bajo la ropa."+ 
        "Descarta la armadura visible.",0, [TreasureKind::ARMOR], Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Bichgooth", 2, bc, p, 0)

        #El rey de rosa
        bc = NumericBadConsequence.new("Pierdes 5 niveles y "+
        "3 tesoros visibles",5,3,0)
        p = Prize.new(4,2)
        @unusedMonsters << Monster.new("El rey de rosa", 13, bc, p, 0)

        #La que redacta en las tinieblas
        bc = NumericBadConsequence.new("Toses los pulmones y " + 
        "pierdes dos niveles",2,0,0)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("La que redacta en las tinieblas", 2, bc, p, 0)

        #Los hondos
        bc = DeathBadConsequence.new("Estos monstruos resultan bastante superficiales " +
        "aburren mortalmente. Estas muerto.")
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Los hondos", 8, bc, p, 0)

        #Semillas Cthulhu
        bc = NumericBadConsequence.new("Pierdes 2 niveles y " + 
        "2 tesoros ocultos",2,0,2)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Semillas Cthulhu", 4, bc, p, 0)

        #Dameargo
        bc = SpecificBadConsequence.new("Te intentas escaquear." +
        "Pierdes una mano visible",0,[TreasureKind::ONEHAND], Array.new)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Dameargo", 1, bc, p, 0)

        #Pollipolipo volante
        bc = NumericBadConsequence.new("Da mucho asquito. Pierdes"+ 
        " 3 niveles", 3, 0,0)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Pollipolipo volante", 3, bc, p, 0)

        #Yskhtihyssg-Goth
        bc = DeathBadConsequence.new("No le hace gracia que pronuncien mal su " +
        "nombre. Estas muerto.")
        p = Prize.new(3,1)
        @unusedMonsters << Monster.new("Yskhtihyssg-Goth", 12, bc, p, 0)

        #Familia feliz
        bc = DeathBadConsequence.new("La familia te atrapa. Estás muerto.")
        p = Prize.new(4,1)
        @unusedMonsters << Monster.new("Familia feliz", 1, bc, p, 0)

        #Roboggoth
        bc = SpecificBadConsequence.new("La quinta directiva " + 
        "primaria te obliga a perder 2 niveles y un tesoro 2 manos visible.", 2,
        [TreasureKind::BOTHHANDS], Array.new)
        p = Prize.new(2,1)
        @unusedMonsters << Monster.new("Roboggoth", 8, bc, p, 0)

        #El espia
        bc = SpecificBadConsequence.new("Te asusta en la noche. " +
        "Pierdes un casco visible.", 0,[TreasureKind::HELMET], Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("El espia", 5, bc, p, 0)

        #El lenguas
        bc = NumericBadConsequence.new("Menudo susto te llevas."+
        " Pierdes 2 niveles y 5 tesoros visibles.",2,5,0)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("El lenguas", 20, bc, p, 0)

        #Bicefalo
        bc = SpecificBadConsequence.new("Te faltan manos para tanta"+ 
        "cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos", 3,
        [TreasureKind::ONEHAND,TreasureKind::ONEHAND,TreasureKind::BOTHHANDS],
        Array.new)
        p = Prize.new(1,1)
        @unusedMonsters << Monster.new("Bicefalo", 20, bc, p, 0)
        
        
        # NUEVOS MONSTRUOS CON SECTARIOS

        
        #El mal indecible impronunciable 
        badConsequence = SpecificBadConsequence.new("Pierdes 1 mano visible.", 0,
                     [TreasureKind::ONEHAND], Array.new)
        prize = Prize.new(3,1)
        @unusedMonsters << Monster.new("El mal indecible impronunciable", 10, badConsequence, prize, -2)

        #Testigos Oculares
        badConsequence = NumericBadConsequence.new("Pierdes tus tesoros visibles. Jajaja.", 0, BadConsequence.MAXtreasures, 0)
        prize = Prize.new(2,1)
        @unusedMonsters<< Monster.new("Testigos Oculares", 6, badConsequence, prize, 2)

        # El gran cthulhu
        badConsequence = DeathBadConsequence.new("Hoy no es tu día de suerte. Mueres.")
        prize = Prize.new(2,5)
        @unusedMonsters << Monster.new("El gran cthulhu", 20, badConsequence, prize, 4)

        # Serpiente Político
        badConsequence = NumericBadConsequence.new("Tu gobierno te recorta 2 niveles", 2, 0, 0)
        prize = Prize.new(2,1)
        @unusedMonsters << Monster.new("Serpiente Político", 8, badConsequence, prize, -2)

        # Felpuggoth
        badConsequence = SpecificBadConsequence.new("Pierdes tu casco y tu armadura visible. " +
                      "\n\tPierdes tus manos ocultas", 0,
                      [TreasureKind::ARMOR, TreasureKind::HELMET], [TreasureKind::BOTHHANDS, TreasureKind::ONEHAND, TreasureKind::ONEHAND])
        prize = Prize.new(1,1)
        @unusedMonsters<< Monster.new("Felpuggoth", 2, badConsequence, prize, 5)

        # Shoggoth
        badConsequence = NumericBadConsequence.new("Pierdes 2 niveles", 2, 0, 0)
        prize = Prize.new(4,2)
        @unusedMonsters<< Monster.new("Shoggoth", 16, badConsequence, prize, -4)

        # Lolitagooth
        badConsequence = NumericBadConsequence.new("Pintalabios negro. Pierdes" +
                         "\n\t2 niveles", 2, 0, 0)
        prize = Prize.new(1,1)
        @unusedMonsters<< Monster.new("Lolitagooth", 2, badConsequence, prize, 3)
      end

      def shuffleTreasures
        @unusedTreasures.shuffle!
      end

      def shuffleMonsters
        @unusedMonsters.shuffle!
      end

      def shuffleCultists
        @unusedCultists.shuffle!
      end
  end
end