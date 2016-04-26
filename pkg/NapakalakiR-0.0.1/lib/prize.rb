#encoding: utf-8
module NapakalakiGame
class Prize
  def initialize(treasures, levels)
    @treasures=treasures
    @levels=levels
  end
  attr_reader :treasures, :levels
  def to_s
    "Tesoros : "+@treasures.to_s+"\n Niveles : "+@levels.to_s+"\n"
  end
  
end
end
