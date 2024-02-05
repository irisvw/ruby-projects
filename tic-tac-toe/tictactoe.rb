class Cell
    attr_accessor :value, :name
    attr_reader :col, :row

    def initialize(name, value, col, row)
        @name = name
        @value = value
        @col = col
        @row = row
    end

    def is_empty?
        return (value == " ") ? true : false
    end
end

class Board
    attr_accessor :cells

    def initialize(array)
        @cells = array
    end

    def victory?(row, col, mark)
        row_cells = @cells.select {|cell| cell.row == row }
        col_cells = @cells.select {|cell| cell.col == col }
        diagonal1 = @cells.select {|cell| cell.name == "a1" || cell.name == "b2" || cell.name == "c3"}
        diagonal2 = @cells.select {|cell| cell.name == "a3" || cell.name == "b2" || cell.name == "c1"}

        if (row_cells.all? {|cell| cell.value == mark })
            return true
        elsif (col_cells.all? { |cell| cell.value == mark })
            return true
        elsif (diagonal1.all? { |cell| cell.value == mark })
            return true
        elsif (diagonal2.all? { |cell| cell.value == mark })
            return true
        end
        false
    end

    def is_full?
        @cells.all? {|cell| cell.value != " "}
    end

    def clear()
        @cells.each { |cell| cell.value = " "}
    end
end

a1 = Cell.new("a1", " ", "a", 1)
a2 = Cell.new("a2", " ", "a", 2)
a3 = Cell.new("a3", " ", "a", 3)
b1 = Cell.new("b1", " ", "b", 1)
b2 = Cell.new("b2", " ", "b", 2)
b3 = Cell.new("b3", " ", "b", 3)
c1 = Cell.new("c1", " ", "c", 1)
c2 = Cell.new("c2", " ", "c", 2)
c3 = Cell.new("c3", " ", "c", 3)
cell_array = [a1, a2, a3, b1, b2, b3, c1, c2, c3]

current_player = "Player 1"
board = Board.new(cell_array)
game = true

while (game)
    puts "#{current_player}, where would you like to place your mark?"
    user_input = gets.chomp.downcase

    if ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"].include?(user_input)
        input_col = user_input.chars[0]
        input_row = user_input.chars[1].to_i
        input_cell = cell_array.find {|cell| cell.row == input_row && cell.col == input_col}

        if (input_cell.is_empty?)
            if (current_player == "Player 1")
                input_cell.value = "x"
                if (board.victory?(input_row, input_col, "x"))
                    puts "#{current_player} is the winner! Would you like to start a new game? y/n"
                    yn_input = gets.chomp.downcase
                    game = false;
                elsif (board.is_full?)
                    puts "It's a tie. Would you like to start a new game? y/n"
                    yn_input = gets.chomp.downcase
                    game = false;
                end
                current_player = "Player 2"

            elsif (current_player == "Player 2")
                input_cell.value = "o"
                if (board.victory?(input_row, input_col, "o"))
                    puts "#{current_player} is the winner! Would you like to start a new game? y/n"
                    yn_input = gets.chomp.downcase
                    game = false;
                elsif (board.is_full?)
                    puts "It's a tie. Would you like to start a new game? y/n"
                    yn_input = gets.chomp.downcase
                    game = false;
                end
                current_player = "Player 1"
            end
        else
            puts "That space is already taken."
        end
    else
        puts "Please specify your input as column-row, eg 'a1' or 'c2'."
    end

    puts "
        | a | b | c |
     ---+---+---+---+
      3 | #{a3.value} | #{b3.value} | #{c3.value} |
     ---+---+---+---+
      2 | #{a2.value} | #{b2.value} | #{c2.value} |
     ---+---+---+---+
      1 | #{a1.value} | #{b1.value} | #{c1.value} |
     ---+---+---+---+"

     while (!game && (yn_input != "y" || yn_input != "n"))
        if (yn_input == "y")
            board.clear()
            current_player = "Player 1"
            yn_input = ""
            game = true
            break
        elsif (yn_input == "n")
            board.clear()
            game = false
            yn_input = ""
            break
        else
            puts "Invalid input. Please reply with 'y' or 'n'."
            yn_input = gets.chomp.downcase
        end
    end
end