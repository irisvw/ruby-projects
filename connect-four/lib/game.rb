class Game
  attr_reader :board

  def initialize
    @board = create_board
    @player1 = Player.new("Player 1", "x")
    @player2 = Player.new("Player 2", "o")
    @current_player = @player1
  end

  # create 7 by 6 grid
  def create_board
    array = []
    6.times do |x|
      7.times do |y|
        array << Cell.new(x, y)
      end
    end
    array
  end

  def play
    loop do
      display_board
      cell = place_token
      mark_space(cell)
      victory?(cell)
      draw?
      switch_player
    end
    # display board
    # ask player for input
    # verify input (int between 0 and 6)
    # check if that column is free
    # if not, ask for input

    # if free, place token in lowest free space
    # check for victory or draw
    # display board
    # ask player for input
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def player_input
    puts "In which column would you like to drop your token?"
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

  def diagonal1(cell)
    x = cell.col
    y = cell.row
    diag = [[x-3, y-3], [x-2, y-2], [x-1, y-1], [x, y], [x+1, y+1], [x+2, y+2], [x+3, y+3]]
    diag.keep_if { |c| c[0].between?(0, 7) && c[1].between?(0,6)}
    return nil if diag.length < 4
    diag.map! { |c| find_cell(c[0], c[1])}
    # keep cell if valid cell
  end

  def diagonal2(cell)
    x = cell.col
    y = cell.row
    diag = [[x-3, y+3], [x-2, y+2], [x-1, y+1], [x, y], [x+1, y-1], [x+2, y-2], [x+3, y-3]]
    diag.keep_if { |c| c[0].between?(0, 7) && c[1].between?(0,6)}
    return nil if diag.length < 4
    diag.map! { |c| find_cell(c[0], c[1])}
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
    cell_row = cell.row
    cell_col = cell.col

    return (find_four?(row_cells(cell_row)) ||
            find_four?(col_cells(cell_col)) ||
            find_four?(diagonals(cell)))
  end

  # returns lowest free spot or nil if none found
  def col_free(i)
    col = col_cells(i)
    col.find { |c| c.free? }
  end

  # find a single cell by its row and col. testing purposes only
  def find_cell(row, col)
    @board.find { |c| c.row == row && c.col == col}
  end

  def display_board
    puts "
     | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
    -+---+---+---+---+---+---+---+-
     |   |   |   |   |   |   |   |
    -+---+---+---+---+---+---+---+-
     |   |   |   |   |   |   |   |
    -+---+---+---+---+---+---+---+-
     |   |   |   |   |   |   |   |
    -+---+---+---+---+---+---+---+-
     |   |   |   |   |   |   |   |
    -+---+---+---+---+---+---+---+-
     |   |   |   |   |   |   |   |
    -+---+---+---+---+---+---+---+-
     |   |   |   |   |   |   |   |
    -+---+---+---+---+---+---+---+-"

    # get each row of cells
    # map their values
    # join each row with separator " | "
  end

end