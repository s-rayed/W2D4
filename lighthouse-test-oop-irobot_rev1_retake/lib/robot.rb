class Robot

  CAPACITY = 250

  attr_reader :items, :health
  attr_accessor :equipped_weapon

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
    else
      if items_weight < Robot::CAPACITY
        @items << item
      end
    end
  end

  def items_weight
    total_weight = 0
    @items.each do |item|
      total_weight += item.weight
    end
    total_weight
  end

  def wound(amount)
    if amount <= 100
      @health -= amount
    else
      @health = 0
    end
  end

  def heal(amount)
    if (@health + amount) < 100
      @health += amount
    else
      @health = 100
    end
  end

  def attack(enemy)
    if !equipped_weapon.nil?
      equipped_weapon.hit(enemy)
    else
      enemy.wound(5)
    end 
  end



end
