require_relative 'invalid_input_error'

class InvalidRollError < InvalidInputError
  def initialize(msg="Invalid input roll data")
    super
  end
end
