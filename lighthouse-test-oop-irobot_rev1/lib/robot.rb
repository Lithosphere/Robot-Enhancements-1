require_relative "plasma_cannons.rb"

class AlreadyDeadError < StandardError

end
class OnlyRobotsError < StandardError

end

class Robot
  attr_reader :position, :items, :items_weight, :health, :damage
  attr_accessor :equipped_weapon

  # @@capacity = 250

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @damage = 5
    @equipped_weapon = nil
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)

    capacity = 250

    if item.class.superclass == Weapon && items_weight < capacity && item.weight <= capacity
      @items_weight += item.weight
      @items << item
      @equipped_weapon = item
    elsif items_weight < capacity && item.weight <= capacity
      @items_weight += item.weight
      @items << item
    end

    # MM
    # if items_weight < capacity && item.weight <= capacity
    #   if item.class.superclass == Weapon
    #     @items_weight += item.weight
    #     @equipped_weapon = item
    #   else
    #     @items_weight += item.weight
    #     @items << item
    #   end
    # end

  end

  def wound(damage)
    @health -= damage
    if health <= 0
      @health = 0
    end
  end

  def heal(amount)
    self.heal!
    @health += amount
    if health >= 100
      @health = 100
    end
  rescue AlreadyDeadError => e
    puts e.message
  end

  def attack(enemy)
    self.attack!(enemy)
    if enemy.class == Robot && @equipped_weapon.nil?
      enemy.wound(damage)
    else
      @equipped_weapon.hit(enemy)
    end
  rescue OnlyRobotsError => e
    puts e.message
  end

  def heal!
    if @health <= 0
      raise AlreadyDeadError, "Robot is already dead! You can't heal a dead robot!"
    end
  end

  def attack!(enemy)
    if enemy.class != Robot
      raise OnlyRobotsError, "You cannot attack that object"
    end
  end



end
# testing codes
robot = Robot.new
robot.wound(1000)
robot.heal(1000)
robot2 = Robot.new
plasmacannon = PlasmaCannon.new
robot.attack(plasmacannon)
robot.attack(robot2)
puts robot2.health
