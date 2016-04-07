#encoding: utf-8

class Treasure
  
  def initialize n, bonus, t
    @name=n
    @bonus=bonus
    @type=t
  end
  
  attr_reader :name, :bonus, :type
end
