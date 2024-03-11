require_relative 'lib/cell.rb'
require_relative 'lib/player.rb'
require_relative 'lib/game.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#create_board' do
    it 'creates a board containing of 42 cells' do
      expect(game.board.length).to eq(42)
    end

    it 'has a first cell with the coordinates (0,0)' do
      first_cell = game.board.first
      expect(first_cell.row).to eq(0)
    end

    it 'has a first cell with the coordinates (0,0)' do
      first_cell = game.board.first
      expect(first_cell.col).to eq(0)
    end

    it 'has a last cell with the coordinates (5,6)' do
      last_cell = game.board.last
      expect(last_cell.row).to eq(5)
    end

    it 'has a last cell with the coordinates (5,6)' do
      last_cell = game.board.last
      expect(last_cell.col).to eq(6)
    end

    it 'has only empty cells' do
      values = game.board.map { |cell| cell.value }
      expect(values.all?(" ")).to be true
    end
  end

  describe '#player_input' do
    context 'when user inputs a valid input' do
      before do
        allow(game).to receive(:gets).and_return("3")
      end

      it 'does not display an error message when input is valid' do
        expect(game).not_to receive(:puts)
        game.player_input
      end

      it 'returns the input when input is valid' do
        expect(game.player_input).to eq(3)
      end
    end
    
    context 'when user inputs something invalid once, then something valid' do
      before do
        allow(game).to receive(:gets).and_return("7", "5")
      end

      it 'puts an error message once if input is invalid' do
        error_message = "Please enter a value between 0 and 6."
        expect(game).to receive(:puts).with(error_message).once
        game.player_input
      end
    end
  end

  describe '#col' do
    it 'returns an array of six cells' do
      expect(game.col_cells(1).length).to eq(6)
    end
  end

  describe '#row' do
    it 'returns an array of seven cells' do
      expect(game.row_cells(1).length).to eq(7)
    end
  end

  describe '#find_four' do
    xit 'returns false when there are no four consecutive identical marks' do
    end
    
    xit 'returns true when there are four consecutive identical marks' do
    end
  end

  describe '#victory?' do
    xit 'returns false when four in a row is not found' do
    end

    xit 'returns true when four in a row is found on a row' do
    end

    xit 'returns true when four in a row is found on a column' do
    end

    xit 'returns true when four in a row is found on a diagonal' do
    end
  end

  describe '#col_free' do

    context 'when the selected column is full' do
      before do
        column = game.col(1)
        column.each { |cell| cell.value = "x" }
      end

      it 'returns nil' do
        expect(game.col_free(1)).to be nil
      end
    end

    context 'when the selected column has two cells filled' do
      xit 'returns the lowest free cell in the column' do
        expect(game.col_free(1)).to be
      end
    end

    context 'when the selected column is empty' do
      xit 'returns the lowest cell in the column' do
        expect(game.col_free(1)).to be
      end
    end
  end
end