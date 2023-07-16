require 'optparse'
require_relative 'bowling/bowling_text_parser'
require_relative 'bowling/bowling_game'
require_relative 'bowling/player'
require_relative 'helpers/bowling_console_helper'

class Main
  def run(args)
    options = {}
    parser = OptionParser.new do |parser|
      parser.banner = 'Usage: bowling [options]'

      parser.on('-f', '--file-path FILE_PATH', 'Bowling input file path') do |file_path|
        game = BowlingGame.new(BowlingTextParser.new(file_path))
        handle_game(game)
      end

      parser.on('-h', '--help', 'Prints this help') do
        puts parser
        exit
      end
    end

    parser.parse!(into: options)
    puts parser.help if options.empty?
  end

  def handle_game(game)
    game.run
    BowlingConsoleHelper.print_score_table game.players
  rescue InvalidInputError => e
    puts "Error parsing input: #{e.message}"
  end
end
