class Game
  attr_reader :board

  def initialize
    @board = create_board
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

  def player_input
    loop do
      input = gets.chomp.to_i 
      return input if input.between?(0, 6)
      puts "Please enter a value between 0 and 6."
    end
  end

  def place_token
    loop do
      # get player input
      input = player_input
      # check if column is empty
      cell = col_free(input)
      # return first empty cell
      return cell unless cell.nil?
      puts "That column is full."
    end
  end

  def diagonals(row, col)
    # diag1 = [x-3, y-3], [x-2, y-2], [x-1, y-1], [x, y], [x+1, y+1], [x+2, y+2], [x+3, y+3]
    # diag2 = [x-3, y+3], [x-2, y+2], [x-1, y+1], [x, y], [x+1, y-1], [x+2, y-2], [x+3, y-3]
    # keep cell if valid cell
  end

  # get entire row
  def row_cells(i)
    @board.select { |cell| cell.row == i }
  end

  # get entire column
  def col_cells(i)
    @board.select { |cell| cell.col == i }
  end

  def find_four?(line)
    # check line for four in a row
  end

  def victory?
    find_four?(row_cells(i))
    find_four?(col_cells(i))
    find_four?(diagonals(i))
  end

  def col_free(i)
    # returns lowest free spot or nil if none found
    col = col_cells(i)
    col.sort_by! { |cell| cell.row }
    col
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