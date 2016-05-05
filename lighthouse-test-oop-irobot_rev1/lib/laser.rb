require_relative 'weapon.rb'

class Laser < Weapon

  def initialize
    @name = "Laser"
    @weight = 125
    @damage = 25
  end

end