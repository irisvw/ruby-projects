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
        error_message = "Please enter a value between 0 and 6."
        expect(game).not_to receive(:puts).with(error_message)
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
        message = "In which column would you like to drop your token?"
        error_message = "Please enter a value between 0 and 6."
        allow(game).to receive(:puts).with(message).once
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

  describe '#diagonal' do
    context 'when the diagonal is too short' do
      it 'returns nil' do
      end
    end

    context 'when the diagonal is long enough' do
      it 'returns a line of seven cells' do
      end
  end

  describe '#find_four?' do
    context 'when there are no four consecutive identical marks' do
      before do
        row = game.row_cells(1)
        row.each { |c| c.value = "o" }
        #game.set_instance_variable(:current_player)
      end

      let(:current_player) { player1 }

      it 'returns false ' do
        row = game.row_cells(1)
        expect(game.find_four?(row)).to be false
      end
    end
    
    context 'when there are four consecutive identical marks' do
      before do
        row = game.row_cells(1)
        row.each { |c| c.value = "x" }
      end

      let(:current_player) { player1 }
      it 'returns true ' do
        row = game.row_cells(1)
        expect(game.find_four?(row)).to be true
      end

      it 'returns false when not all marks match' do
        column = game.col_cells(0)
        expect(game.find_four?(column)).to be false
      end
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
        column = game.col_cells(1)
        column.each { |cell| cell.value = "x" }
      end

      it 'returns nil' do
        expect(game.col_free(1)).to be nil
      end
    end

    context 'when the selected column has two cells filled' do
      before do
        cell1 = game.find_cell(0, 1)
        cell2 = game.find_cell(1, 1)
        cell1.value = "x"
        cell2.value = "x"
      end

      it 'returns the lowest free cell in the column' do
        cell = game.find_cell(2,1)
        expect(game.col_free(1)).to be(cell)
      end
    end

    context 'when the selected column is empty' do
      it 'returns the lowest cell in the column' do
        cell = game.find_cell(0,1)
        expect(game.col_free(1)).to be(cell)
      end
    end
  end
end