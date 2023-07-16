require 'bowling/bowling_game'

RSpec.describe BowlingGame do
  context 'when input is valid a gutter' do
    let(:payload) { Array.new(12, %w[jonh 10]) }
    let(:game) { described_class.new(InputParserMock.new(payload)) }

    it 'adds a player' do
      game.run
      expect(game.player?('jonh')).to eq true
    end

    it 'calculates the right score' do
      game.run
      expect(game.get_player('jonh').total_score).to eq 300
    end
  end
end

class InputParserMock
  def initialize(payload)
    @payload = payload
  end

  def parse
    @payload
  end
end
