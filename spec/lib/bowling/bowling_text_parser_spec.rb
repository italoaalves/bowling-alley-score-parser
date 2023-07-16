require 'bowling/bowling_text_parser'

RSpec.describe BowlingTextParser do
  context 'when input file is valid' do
    let(:scores) { file_fixture('scores.txt') }

    context 'with two players' do
      it 'does not raises InvalidFileError' do
        expect { described_class.new(scores).parse }.to_not raise_error
      end
    end
  end

  context 'when input file is invalid' do
    let(:empty) { file_fixture('empty.txt') }
    let(:freetext) { file_fixture('free-text.txt') }
    let(:invalidscore) { file_fixture('invalid-score.txt') }
    let(:negative) { file_fixture('negative.txt') }

    context 'with an empty text' do
      it 'raises InvalidFileError' do
        expect { described_class.new(empty).parse }.to raise_error('File is empty')
      end
    end

    context 'with free text' do
      it 'raises InvalidFileError' do
        expect { described_class.new(freetext).parse }.to raise_error(InvalidFileError)
      end
    end

    context 'with invalid score' do
      it 'raises InvalidFileError' do
        expect { described_class.new(invalidscore).parse }.to raise_error(InvalidFileError)
      end
    end

    context 'with negative score' do
      it 'raises InvalidFileError' do
        expect { described_class.new(negative).parse }.to raise_error(InvalidFileError)
      end
    end
  end
end
