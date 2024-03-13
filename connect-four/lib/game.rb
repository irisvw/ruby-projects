class Game
  attr_reader :board

  def initialize
    @board = create_board
    @player1 = Player.new("\e[31mPlayer 1\e[0m", "\e[31m\u2665\e[0m")
    @player2 = Player.new("\e[34mPlayer 2\e[0m", "\e[34m\u2665\e[0m")
    @current_player = @player1
  end

  # create 7 by 6 grid
  def create_board
    array = []
    7.times do |x|
      6.times do |y|
        array << Cell.new(x, y)
      end
    end
    array
  end

  def play
    game_state = nil
    loop do
      display_board
      cell = place_token
      mark_space(cell)
      game_state = game_over?(cell)
      break unless game_state.nil?
      switch_player
    end
    display_board
    game_state == "victory" ? victory_message : draw_message
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def player_input
    puts "#{@current_player.name}, in which column would you like to drop your token?"
    loop do
      input = gets.chomp.to_i 
      return input if input.between?(0, 6)
      puts "Please enter a value between 0 and 6."
    end
  end

  # get player input and return first empty cell in a given column
  def place_token
    loop do
      input = player_input
      cell = col_free(input)
      return cell unless cell.nil?
      puts "That column is full."
    end
  end

  def mark_space(cell)
    cell.value = @current_player.token
  end

  def diagonal(cell, type)
    x = cell.col
    y = cell.row
    diag = main_diag(x, y) if type == "main"
    diag = counter_diag(x, y) if type == "counter"
    diag.keep_if { |c| c[0].between?(0, 6) && c[1].between?(0, 5)}
    return nil if diag.length < 4

    diag.map! { |c| find_cell(c[0], c[1])}
  end

  # get main diagonal (\)
  def main_diag(x, y)
    [[x-3, y+3], [x-2, y+2], [x-1, y+1], [x, y], [x+1, y-1], [x+2, y-2], [x+3, y-3]]
  end

  # get counter diagonal (/)
  def counter_diag(x, y)
    [[x-3, y-3], [x-2, y-2], [x-1, y-1], [x, y], [x+1, y+1], [x+2, y+2], [x+3, y+3]]
  end

  # get entire row
  def row_cells(cell_row)
    line = @board.select { |c| c.row == cell_row }
    line.sort_by! { |c| c.col }
  end

  # get entire column
  def col_cells(cell_col)
    line = @board.select { |c| c.col == cell_col }
    line.sort_by! { |c| c.row }
  end

  # check line for four in a row
  def find_four?(line)
    return false if line.nil?

    line.map! { |c| c.value }
    four = "#{@current_player.token}" * 4
    line.join.include?(four)
  end

  def victory?(cell)
    cell_col = cell.col
    cell_row = cell.row

    return (find_four?(row_cells(cell_row)) ||
            find_four?(col_cells(cell_col)) ||
            find_four?(diagonal(cell, "main")) ||
            find_four?(diagonal(cell, "counter")))
  end

  def full?
    @board.all? {|cell| cell.value != " "}
  end

  def game_over?(cell)
    return "victory" if victory?(cell)
    return "draw" if full?
    return nil
  end

  # returns lowest free spot or nil if none found
  def col_free(i)
    col = col_cells(i)
    col.find { |c| c.free? }
  end

  # find a single cell by its row and col
  def find_cell(col, row)
    @board.find { |c| c.row == row && c.col == col}
  end

  def display_board
    puts <<~HEREDOC
     | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
    -+---+---+---+---+---+---+---+-
     | #{row_cells(5).map { |c| c.value }.join(" | ")} | 
    -+---+---+---+---+---+---+---+-
     | #{row_cells(4).map { |c| c.value }.join(" | ")} | 
    -+---+---+---+---+---+---+---+-
     | #{row_cells(3).map { |c| c.value }.join(" | ")} | 
    -+---+---+---+---+---+---+---+-
     | #{row_cells(2).map { |c| c.value }.join(" | ")} | 
    -+---+---+---+---+---+---+---+-
     | #{row_cells(1).map { |c| c.value }.join(" | ")} | 
    -+---+---+---+---+---+---+---+-
     | #{row_cells(0).map { |c| c.value }.join(" | ")} | 
    -+---+---+---+---+---+---+---+-
    HEREDOC
  end

  def clear
    @board.each { |c| c.value = " "}
  end

  def victory_message
    puts "#{@current_player.name} is the winner!"
    play_again
  end

  def draw_message
    puts "It's a draw."
    play_again
  end

  def play_again
    puts "Would you like to play again? (y/n)"
    input = gets.chomp.downcase
    if input == "y"
      clear
      play
      @current_player = @player1
    end
  end
end
