require_relative '../roll'
require_relative '../errors/invalid_roll_error'

class Frame
  attr_accessor :next
  attr_reader :rolls

  MAX_ROLLS = 2
  MAX_PINS = 10

  def initialize
    @rolls = []
    @next = nil
  end

  def add_roll(pins)
    raise InvalidRollError, 'Frame can only have 2 rolls' if @rolls.length > 1

    validates(pins)

    new_roll = Roll.new(pins)
    @rolls << new_roll

    if strike?
      new_roll.symbol = 'X'
    elsif spare?
      new_roll.symbol = '/'
    end
  end

  def finished?
    @rolls.length == MAX_ROLLS or strike?
  end

  def strike?
    @rolls[0].to_i == MAX_PINS
  end

  def spare?
    (@rolls[0].to_i + rolls[1].to_i) == MAX_PINS
  end

  def score
    if strike?
      total_pins + @next.strike_bonus
    elsif spare?
      total_pins + @next.spare_bonus
    else
      total_pins
    end
  end

  def spare_bonus
    rolls[0].to_i
  end

  def strike_bonus
    return @rolls[0].to_i + @next.total_pins if strike?

    total_pins
  end

  def rolls_tree
    @rolls.map(&:to_s)
  end

  def total_pins
    @rolls.sum(&:to_i)
  end

  private

  def validates(pins)
    return if pins == 'F'
    raise InvalidRollError, 'Pins must be between 0 and 10, or F indicating a Foul' if pins.to_i > MAX_PINS || pins.to_i.negative?
    raise InvalidRollError, 'Total pins in a frame must be less than or equals 10' if (pins.to_i  + total_pins) > MAX_PINS
  end
end
