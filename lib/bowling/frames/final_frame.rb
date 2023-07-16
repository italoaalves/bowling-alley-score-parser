class FinalFrame < Frame
  MAX_PINS = 10
  MAX_ROLLS = 3

  def add_roll(pins)
    raise InvalidRollError, 'Final frame can only have 3 rolls at max' if @rolls.length >= 3

    new_roll = Roll.new(pins)
    @rolls << new_roll

    if pins == '10'
      new_roll.symbol = 'X'
    elsif spare?
      new_roll.symbol = '/'
    end
  end

  def finished?
    @rolls.length >= MAX_ROLLS || @rolls.length > 1 && total_pins < MAX_PINS
  end

  def strike?
    false
  end

  def spare?
    @rolls.length == MAX_ROLLS - 1 && total_pins == MAX_PINS
  end

  def score
    total_pins
  end

  def strike_bonus
    0
  end
end
