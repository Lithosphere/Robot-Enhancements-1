require_relative 'item.rb'
class Weapon < Item

  attr_reader :damage

  def initialize(name, weight, damage)
    @name = name
    @weight = weight
    @damage = damage
  end

  def hit(enemy)
    enemy.wound(damage)
  end

end