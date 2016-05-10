#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'bad_consequence.rb'

module NapakalakiGame
  
  class DeathBadConsequence < NumericBadConsequence 
    
    public_class_method :new

    def initialize(text)
      super(text, 0, BadConsequence.MAXtreasures, 
        BadConsequence.MAXtreasures)
    end
    
    def to_s
      @textoIntroduccion + "\n\tTexto = " + @text.to_s
    end
    
  end

end
