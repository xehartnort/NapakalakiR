#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prize.rb'
require_relative 'bad_consequence.rb'

class Monster
  def initialize(name,lvl,bc,prize)
    @name=name
    @level=lvl
    @bc=bc
    @prize=prize
  end
  attr_reader :name, :level, :bc, :prize
  
  def to_s
    "Nombre :"+@name+"\nNivel :"+@level.to_s+"\nMal rollo :"+
      @bc.to_s+"\nBuen rollo:"+@prize.to_s 
  end
end

if __FILE__ == $0
  puts Monster.new("hola",2,nil,Prize.new(2,2)).to_s
end
