#encoding: utf-8
module NapakalakiGame
class Treasure
  
  def initialize n, bonus, t
    @name=n
    @bonus=bonus
    @type=t
  end
  
  attr_reader :name, :bonus, :type
  def to_s
    "\nNombre: "+ @name + "\n" +
      "Bonus: "+ @bonus.to_s + "\n" +
      "Type: "+ @type.to_s + "\n"
  end
end
end