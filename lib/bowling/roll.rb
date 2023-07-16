class Roll
  attr_accessor :symbol

  def initialize(pins)
    @value = pins == 'F' ? 0 : pins.to_i
    @symbol = pins
  end

  def to_s
    @symbol
  end

  def to_i
    @value
  end
end
