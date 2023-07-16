require_relative 'errors/invalid_file_error'

class BowlingTextParser
  def initialize(file_path)
    @file_path = File.join(Dir.getwd, file_path)
  end

  def parse
    raise InvalidFileError, 'File is empty' if File.zero?(@file_path)

    begin
      File.readlines(@file_path).each_with_index.map do |line, index|
        raise InvalidFileError, invalid_input_msg(line, index) unless valid_format? line

        player_name, roll_value = line.chomp.split
        [player_name, roll_value]
      end
    rescue Errno::ENOENT => e
      raise InvalidFileError, e.message
    end
  end

  private

  def valid_format?(line)
    regex = Regexp.new('[A-Za-z]+\\s+[F0-9]+', Regexp::IGNORECASE)
    regex.match line
  end

  def invalid_input_msg(line, index)
    <<~INPUT
      Invalid file

      On file: #{@file_path}
      On line: #{index + 1}
      value: #{line.chomp}

      Please update the input file to have the player's name followed by a space
      and then the number of pins knocked down from 1 to 10.
      For example: 'John 10'
    INPUT
  end
end
