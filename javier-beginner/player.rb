class Player

  def initialize
    @health = 20
    @direction = :forward
  end

  def play_turn(warrior)
    if warrior.feel.enemy?
      warrior.attack!
    elsif warrior.feel(:backward).captive?
      warrior.rescue! :backward
    elsif warrior.look(:backward).map(&:to_s).any?("Captive")
      warrior.walk! :backward
    elsif warrior.feel.captive?
      warrior.rescue!
    elsif warrior.look.map(&:to_s).any?("Captive")
      warrior.walk!
    elsif warrior.look.map(&:to_s).any?("Wizard") || warrior.look.map(&:to_s).any?("Archer")
      warrior.shoot!
    elsif warrior.feel.wall?
      warrior.pivot!:left
    elsif warrior.health < 10 && took_damage?(warrior)
      warrior.walk!:backwards
    elsif warrior.look.map(&:to_s).any?("wall")
      warrior.walk!
    elsif warrior.health < 20
      warrior.rest!
    else
      warrior.walk!
    end
    @health = warrior.health
  end


  #metodos

  def took_damage?(warrior)
    warrior.health < @health
  end
end
