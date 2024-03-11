# require_relative 'lib/tictactoe.rb'
require_relative 'lib/cell.rb'
require_relative 'lib/player.rb'
require_relative 'lib/board.rb'

# validate functions that determine victory or loss conditions

# victory?
  # check if row_cells correctly returns the row
  # check if col_cells correctly returns the col
  # check if any of the given conditions return true
  # check if it returns false if none of the conditions are true


# is_full?
  # returns true when board is full
  # returns false when it is not

describe Board do

  subject(:game) { described_class.new }

  describe '#row_cells' do
    it 'returns three cells' do
      cells = game.row_cells(2)
      expect(cells.length).to eql(3)
    end

    it 'returns three different cells' do
      cells = game.row_cells(2)
      expect(cells.uniq.length).to eql(3)
    end

    it 'returns three cells that are all in the same row' do
      cells = game.row_cells(1)
      rows = cells.map { |cell| cell.row }
      expect(rows.all?(1)).to be true
    end
  end

  describe '#col_cells' do
    it 'returns three cells' do
      cells = game.col_cells("a")
      expect(cells.length).to eql(3)
    end

    it 'returns three different cells' do
      cells = game.col_cells("b")
      expect(cells.uniq.length).to eql(3)
    end

    it 'returns three cells that are all in the same row' do
      cells = game.col_cells("c")
      cols = cells.map { |cell| cell.col }
      expect(cols.all?("c")).to be true
    end
  end

  describe '#victory?' do

    it 'returns true when there are three adjacent identical marks on a row' do
      game.clear
      game.row_cells(1).each { |cell| cell.value = "x" }
      expect(game.victory?(1, "a", "x")).to be true
    end

    it 'returns true when there are three adjacent identical marks on a column' do
      game.clear
      game.col_cells("a").each { |cell| cell.value = "x" }
      expect(game.victory?(1, "a", "x")).to be true
    end

    it 'returns true when there are three adjacent identical marks on a diagonal' do
      game.clear
      game.diagonal1.each { |cell| cell.value = "x" }
      expect(game.victory?(1, "a", "x")).to be true
    end

    it 'returns false when there are no three adjacent identical marks anywhere' do
      game.clear
      expect(game.victory?(2, "b", "x")).to be false
    end
  end

  describe '#is_full?' do
    it 'returns false when the board is empty' do
      game.clear
      expect(game.is_full?).to be false
    end

    it 'returns false when the board is not empty' do
      game.clear
      game.diagonal1.each { |cell| cell.value = "x" }
      expect(game.is_full?).to be false
    end

    it 'returns true when the board is full' do
      game.clear
      game.cells.each { |cell| cell.value = "x" }
      expect(game.is_full?).to be true
    end
  end
end