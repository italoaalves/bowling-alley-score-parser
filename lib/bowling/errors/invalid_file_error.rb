require_relative 'invalid_input_error'

class InvalidFileError < InvalidInputError
  def initialize(msg="Invalid input file")
    super
  end
end
