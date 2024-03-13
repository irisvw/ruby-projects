require_relative 'lib/cell.rb'
require_relative 'lib/player.rb'
require_relative 'lib/game.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#create_board' do
    it 'creates a board containing 42 cells' do
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
        message = "Player 1, in which column would you like to drop your token?"
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
        cell = game.find_cell(1, 1)
        expect(game.diagonal(cell, "main")).to be nil
      end
    end

    context 'when the diagonal is a maximum of five' do
      it 'returns a line of five cells' do
        cell = game.find_cell(2, 2)
        expect(game.diagonal(cell, "main").length).to eq(5)
      end
    end

    context 'when the diagonal is a maximum of six' do
      it 'returns a line of six cells' do
        cell = game.find_cell(2, 3)
        expect(game.diagonal(cell, "main").length).to eq(6)
      end
    end
  end

  describe '#find_four?' do
    context 'when there are no four consecutive identical marks' do
      before do
        row = game.row_cells(1)
        row.each { |c| c.value = "o" }
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

    context 'when there are four consecutive identical marks on the diagonal' do
      before do
        cells = [[0,0], [1,1], [2,2], [3,3]]
        cells.map! { |c| game.find_cell(c[0], c[1])}
        cells.each { |c| c.value = "x" }
      end

      let(:current_player) { player1 }
      it 'returns true ' do
        cell = game.find_cell(0, 0)
        diag = game.diagonal(cell, "counter")
        expect(game.find_four?(diag)).to be true
      end
    end
  end

  describe '#victory?' do
    it 'returns false when four in a row is not found' do
      cell = game.find_cell(0,1)
      expect(game.victory?(cell)).to be false
    end

    context 'when four in a row is found on a row' do
      before do
        cells = [[0,2], [0,3], [0,4], [0,5]]
        cells.map! { |c| game.find_cell(c[0], c[1])}
        cells.each { |c| c.value = "x" }
      end

      it 'returns true' do
        cell = game.find_cell(0,3)
        expect(game.victory?(cell)).to be true
      end
    end
    
    context 'when four in a row is found on a column' do
      before do
        cells = [[0,2], [1,2], [2,2], [3,2]]
        cells.map! { |c| game.find_cell(c[0], c[1])}
        cells.each { |c| c.value = "x" }
      end

      it 'returns true' do
        cell = game.find_cell(0,2)
        expect(game.victory?(cell)).to be true
      end
    end

    context 'when four in a row is found on a counter diagonal' do
      before do
        cells = [[0,0], [1,1], [2,2], [3,3]]
        cells.map! { |c| game.find_cell(c[0], c[1])}
        cells.each { |c| c.value = "x" }
      end

      it 'returns true' do
        cell = game.find_cell(1,1)
        expect(game.victory?(cell)).to be true
      end
    end

    context 'when four in a row is found on a high main diagonal' do
      before do
        cells = [[0,5], [1,4], [2,3], [3,2]]
        cells.map! { |c| game.find_cell(c[0], c[1])}
        cells.each { |c| c.value = "x" }
      end

      it 'returns true' do
        cell = game.find_cell(1,4)
        expect(game.victory?(cell)).to be true
      end
    end

    context 'when four in a row is found on a low main diagonal' do
      before do
        cells = [[0,3], [1,2], [2,1], [3,0]]
        cells.map! { |c| game.find_cell(c[0], c[1])}
        cells.each { |c| c.value = "x" }
      end

      it 'returns true' do
        cell = game.find_cell(1,2)
        expect(game.victory?(cell)).to be true
      end
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
        cell1 = game.find_cell(1, 0)
        cell2 = game.find_cell(1, 1)
        cell1.value = "x"
        cell2.value = "x"
      end

      it 'returns the lowest free cell in the column' do
        cell = game.find_cell(1, 2)
        expect(game.col_free(1)).to be(cell)
      end
    end

    context 'when the selected column is empty' do
      it 'returns the lowest cell in the column' do
        cell = game.find_cell(1, 0)
        expect(game.col_free(1)).to be(cell)
      end
    end
  end
end