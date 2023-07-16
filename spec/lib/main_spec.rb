require 'spec_helper'
require 'main'
require 'bowling/bowling_game'
require 'bowling/bowling_text_parser'

RSpec.describe Main do
  let(:perfect) { file_fixture('perfect.txt') }

  context 'when input file is valid' do
    context 'with strikes in all throwings' do
      it 'prints the game scoreboard to stdout' do
        game = BowlingGame.new(BowlingTextParser.new(perfect))
        expect { described_class.new.handle_game(game) }.to output().to_stdout
      end
    end

    context 'with fouls in all throwings' do
      let(:fouls) { file_fixture('fouls.txt') }

      it 'prints the game scoreboard to stdout' do
        game = BowlingGame.new(BowlingTextParser.new(fouls))
        expect { described_class.new.handle_game(game) }.to output.to_stdout
      end
    end
  end

  context 'when input file is invalid' do
    let(:invalidscore) { file_fixture('invalid-score.txt') }
    let(:negative) { file_fixture('negative.txt') }
    let(:extra) { file_fixture('extra-score.txt') }

    context 'with invalid characters present' do
      xit 'raises the corresponding error message' do
        game = BowlingGame.new(BowlingTextParser.new(negative))
        expect { described_class.new.handle_game(game) }.to raise_error InvalidInputError
      end
    end

    context 'with invalid score' do
      xit 'raises the corresponding error message' do
        game = BowlingGame.new(BowlingTextParser.new(invalidscore))
        expect { described_class.new.handle_game(game) }.to raise_error InvalidFileError
      end
    end

    context 'with invalid number of throwings' do
      xit 'raises the corresponding error message' do
        game = BowlingGame.new(BowlingTextParser.new(extra))
        expect { described_class.new.handle_game(game) }.to raise_error InvalidRollError
      end
    end
  end
end
