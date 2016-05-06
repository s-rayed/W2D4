class Robot

  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end

  CAPACITY = 250

  attr_reader :items
  attr_accessor :equipped_weapon, :health

  def initialize
    @x = 0
    @y = 0
    @items = []
    @health = 100
    @equipped_weapon = nil
  end

  def position
    [@x, @y]
  end

  def move_left
    @x -= 1
  end

  def move_right
    @x += 1
  end

  def move_up
    @y += 1
  end

  def move_down
    @y -= 1
  end

  def pick_up(item)
    if item.is_a?(Weapon)
      @equipped_weapon = item
    elsif item.is_a?(BoxOfBolts) && health <= 80
      item.feed(self)
    else
      @items << item unless items_weight >= Robot::CAPACITY #namespacing not required but its clearer to next developer if used.
    end
  end

  def items_weight
    i_weight = 0
    items.each do |item|
      i_weight += item.weight
    end
    i_weight
  end

  def wound(damage)
    if damage <= 100 
      @health -= damage
    else
      @health = 0
    end
  end

  def heal(amount)
    if @health < 100 && amount < 100
      @health += amount
    else
      @health = 100
    end
  end

  def attack(enemy)
    # binding.pry
    if !@equipped_weapon.nil?
      if (position_diff_x == 1) || (position_diff_y == 1)
        if @equipped_weapon.is_a?(Laser)
          @equipped_weapon.hit(enemy)
        end
      elsif (position_diff_x == 2) || (position_diff_y == 2)
        if @equipped_weapon.is_a?(Grenade)
          @equipped_weapon.hit(enemy)
          remove_instance_variable(:@equipped_weapon)
        end
      else
        equipped_weapon.hit(enemy)
      end
    elsif ((enemy.position[0] - self.position[0]).abs > 1) || ((enemy.position[1] - self.position[1]).abs > 1) && @equipped_weapon.nil?
      
    else
      enemy.wound(5) 
    end
  end

  def heal!
    if @health <= 0
      raise RobotAlreadyDeadError, 'Robot is already dead, it cant be healed fool! this aint no game'
    end
  end

  def attack!(enemy)
    if !enemy.is_a?(Robot)
      raise UnattackableEnemy, 'You cannot attack an enemy that is not a Robot, You wanna start a war?'
    end
  end

  def position_diff_x
    (enemy.position[0] - self.position[0]).abs
  end

  def position_diff_y
    (enemy.position[1] - self.position[1]).abs
  end

end
