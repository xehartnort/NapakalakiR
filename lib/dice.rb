#encoding: utf-8
require 'singleton'

class Dice
  include Singleton
  
  def nextNumber
    rand(6)+1    
  end
end
