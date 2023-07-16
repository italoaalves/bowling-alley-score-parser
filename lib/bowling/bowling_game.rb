class BowlingGame
  attr_reader :players

  def initialize(input_parser)
    @players = {}
    @input_parser = input_parser
  end

  def run
    @input_parser.parse.each do |player_name, roll_value|
      add_player(player_name) unless player?(player_name)
      curr_player = @players[player_name]

      curr_player.add_roll(roll_value)
    end
  end

  def player?(player_name)
    @players.key?(player_name)
  end

  def get_player(player_name)
    @players[player_name]
  end

  private

  def add_player(player_name)
    @players[player_name] = Player.new(player_name)
  end
end
