# Run: ruby game.rb

# GameCharacter – base class (not meant to be instantiated directly)
# Ruby has no native abstract class, so we raise NotImplementedError in any
# method that subclasses MUST override.
class GameCharacter
  attr_reader :health   # shorthand read-only accessor for @health - equiv to
  # def health; @health end 

  def initialize(health)
    @health = health
  end

  # Subclasses must override this – raises an error if called directly
  def takeHit(damage)
    raise NotImplementedError, "#{self.class} must implement takeHit"
  end

  # Default attack value; subclasses may override
  def attack
    1
  end
end

# Wizard – dies instantly from any hit; attacks with spellDamage
class Wizard < GameCharacter
  def initialize(health, spellDamage)
    super(health)               # call parent constructor to set @health
    @spellDamage = spellDamage
  end

  # Wizards are instantly killed by any attack
  def takeHit(damage)
    false
  end

  # Returns spell damage bonus instead of the default 1
  def attack
    @spellDamage
  end
end

# Warrior – shield absorbs part of each hit; uses parent attack (returns 1)
class Warrior < GameCharacter
  def initialize(health, shield)
    super(health)       # call parent constructor to set @health
    @shield = shield
  end

  # Shield absorbs some damage; warrior dies only when health goes negative
  def takeHit(damage)
    net_damage = damage - @shield
    @health -= net_damage
    @health >= 0    # true = alive, false = dead
  end

  # attack is NOT overridden; inherits GameCharacter#attack which returns 1
end

# Helper: prompt the user to build one GameCharacter (Wizard or Warrior)
def create_character
  loop do
    print "Enter a wizard (1) or a warrior (2): "
    choice = gets.chomp

    case choice
    when "1"
      print "Enter health: "
      health = gets.chomp.to_i
      print "Enter spell damage: "
      spell = gets.chomp.to_i
      return Wizard.new(health, spell)
    when "2"
      print "Enter health: "
      health = gets.chomp.to_i
      print "Enter shield strength: "
      shield = gets.chomp.to_i
      return Warrior.new(health, shield)
    else
      puts "Invalid choice. Please enter 1 or 2."
    end
  end
end

# Main – build the array, run the battle (arr is dynamic)
characters = []
# << append to arr
characters << create_character   # character at index 0
characters << create_character   # character at index 1

puts "\nThe battle begins!"

alive = true
round = 0   # 0 = char 1 attacks char 2, 1 = char 2 attacks char 1

while alive
  attacker_idx = round % 2        # alternates 0, 1, 0, 1 …
  defender_idx = 1 - attacker_idx # the other character

  attacker_num = attacker_idx + 1
  defender_num = defender_idx + 1

  damage = characters[attacker_idx].attack
  puts "Character #{attacker_num} attacks for #{damage} damage"

  survived = characters[defender_idx].takeHit(damage)

  if survived
    puts "Character #{defender_num} has #{characters[defender_idx].health} health points left"
  else
    puts "Character #{defender_num} died"
    puts "Character #{attacker_num} wins"
    alive = false
  end

  round += 1
end
