class Cell
  attr_accessor :value
  attr_reader :col, :row

  def initialize(value, col, row)
    @value = value
    @col = col
    @row = row
  end

  def is_empty?
    return (@value == " ")
  end
end

###

class Board
  attr_reader :cells

  def initialize
    @cells = create_board
    @player1 = Player.new("x", true, "Player 1")
    @player2 = Player.new("o", false, "Player 2")
    @current_player = @player1
  end

  def create_board
    [Cell.new(" ", "a", 1), 
     Cell.new(" ", "a", 2), 
     Cell.new(" ", "a", 3), 
     Cell.new(" ", "b", 1), 
     Cell.new(" ", "b", 2), 
     Cell.new(" ", "b", 3),
     Cell.new(" ", "c", 1),
     Cell.new(" ", "c", 2),
     Cell.new(" ", "c", 3)]
  end

  def play
    loop do
      # get user input
      cell = ask_input
      # if user input valid
      # place mark in box
      cell.value = @current_player.mark
      display_board
      # check if victory
      if victory?(cell.row, cell.col, @current_player.mark)
        puts "#{@current_player.name} is the winner!"
        break
      end
      # check if tie
      if is_full?
        puts "It's a tie."
        break
      end
      switch_player
      # display board
    end
  end

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def ask_input
    puts "#{@current_player.name}, where would you like to place your mark?"
    loop do
      user_input = gets.chomp.downcase
      input_col = user_input.chars[0]
      input_row = user_input.chars[1].to_i
      input_cell = find_cell(input_row, input_col)
      if input_cell.nil?
        puts "Invalid input."
        next
      end
      return input_cell if input_cell.is_empty?
      puts "That space is already taken."
    end
  end

  def victory?(row, col, mark)
    row_cells = row_cells(row)
    col_cells = col_cells(col)

    return (
      (row_cells.all? { |cell| cell.value == mark }) ||
      (col_cells.all? { |cell| cell.value == mark }) ||
      (diagonal1.all? { |cell| cell.value == mark }) ||
      (diagonal2.all? { |cell| cell.value == mark }))
  end

  def is_full?
    @cells.all? {|cell| cell.value != " "}
  end

  def clear
    @cells.each { |cell| cell.value = " "}
  end

  def row_cells(row)
    @cells.select { |cell| cell.row == row }
  end

  def col_cells(col)
    @cells.select { |cell| cell.col == col }
  end

  def diagonal1
    @cells.select { |cell| 
      (cell.col == "a" && cell.row == 1) ||                    
      (cell.col == "b" && cell.row == 2) ||                            
      (cell.col == "c" && cell.row == 3) }
  end

  def diagonal2
    @cells.select { |cell| 
      (cell.col == "a" && cell.row == 3) ||
      (cell.col == "b" && cell.row == 2) || 
      (cell.col == "c" && cell.row == 1) }
  end

  def display_board
    puts "
        | a | b | c |
     ---+---+---+---+
      3 | #{@cells[2].value} | #{@cells[5].value} | #{@cells[8].value} |
     ---+---+---+---+
      2 | #{@cells[1].value} | #{@cells[4].value} | #{@cells[7].value} |
     ---+---+---+---+
      1 | #{@cells[0].value} | #{@cells[3].value} | #{@cells[6].value} |
     ---+---+---+---+"
  end

  def find_cell(row, col)
    @cells.find { |cell| cell.row == row && cell.col == col}
  end
end

###

class Player
  attr_reader :mark, :name
  attr_accessor :current

  def initialize(mark, current = false, name)
    @mark = mark
    @current = current
    @name = name
  end

  # def ask_input
  #   puts "#{current_player}, where would you like to place your mark?"
  #   loop do
  #     user_input = gets.chomp.downcase
  #     input_col = user_input.chars[0]
  #     input_row = user_input.chars[1].to_i
  #     input_cell = cell_array.find { |cell| cell.row == input_row && cell.col == input_col }
  #     break if input_cell.is_empty?
  # end
end

# current_player = "Player 1"
board = Board.new
board.play

# while (game)
#     puts "#{current_player}, where would you like to place your mark?"
#     user_input = gets.chomp.downcase

#     if ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"].include?(user_input)
#         input_col = user_input.chars[0]
#         input_row = user_input.chars[1].to_i
#         input_cell = cell_array.find { |cell| cell.row == input_row && cell.col == input_col }

#         if (input_cell.is_empty?)
#             if (current_player == "Player 1")
#                 input_cell.value = "x"
#                 if (board.victory?(input_row, input_col, "x"))
#                     puts "#{current_player} is the winner! Would you like to start a new game? y/n"
#                     yn_input = gets.chomp.downcase
#                     game = false;
#                 elsif (board.is_full?)
#                     puts "It's a tie. Would you like to start a new game? y/n"
#                     yn_input = gets.chomp.downcase
#                     game = false;
#                 end
#                 current_player = "Player 2"

#             elsif (current_player == "Player 2")
#                 input_cell.value = "o"
#                 if (board.victory?(input_row, input_col, "o"))
#                     puts "#{current_player} is the winner! Would you like to start a new game? y/n"
#                     yn_input = gets.chomp.downcase
#                     game = false;
#                 elsif (board.is_full?)
#                     puts "It's a tie. Would you like to start a new game? y/n"
#                     yn_input = gets.chomp.downcase
#                     game = false;
#                 end
#                 current_player = "Player 1"
#             end
#         else
#             puts "That space is already taken."
#         end
#     else
#         puts "Please specify your input as column-row, eg 'a1' or 'c2'."
#     end

#     puts "
#         | a | b | c |
#      ---+---+---+---+
#       3 | #{a3.value} | #{b3.value} | #{c3.value} |
#      ---+---+---+---+
#       2 | #{a2.value} | #{b2.value} | #{c2.value} |
#      ---+---+---+---+
#       1 | #{a1.value} | #{b1.value} | #{c1.value} |
#      ---+---+---+---+"

#      while (!game && (yn_input != "y" || yn_input != "n"))
#         if (yn_input == "y")
#             board.clear()
#             current_player = "Player 1"
#             yn_input = ""
#             game = true
#             break
#         elsif (yn_input == "n")
#             board.clear()
#             game = false
#             yn_input = ""
#             break
#         else
#             puts "Invalid input. Please reply with 'y' or 'n'."
#             yn_input = gets.chomp.downcase
#         end
#     end
# end