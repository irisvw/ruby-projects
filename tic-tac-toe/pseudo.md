# How would I set up the different elements of the game?

# Game loop
# Ask player 1 for their input. A1 - C3.
# Check if cell is empty.
# If not, ask for different input.
# If true, store input in cell.
# Check for victory.
# Display the board.
# No victory? Ask player 2 for their input.
# Victory? Congratulate player, ask if they want to player another game. Clear board.

# +---+---+---+
# | x | x | x |
# +---+---+---+
# | x | x | x |
# +---+---+---+
# | x | x | x |
# +---+---+---+

# Think about how you would set up the different elements within the game… 
# What should be a class? Instance variable? Method?

# Check for victory after every turn.

# What should be a class? Each player? The board? Each cell?

#    | a | b | c |
# ---+---+---+---+
#  3 | x | x | x |
# ---+---+---+---+
#  2 | x | x | x |
# ---+---+---+---+
#  1 | x | x | x |
# ---+---+---+---+

# make new board with nine empty cells with empty value, but predetermined spots?
# generate cell the moment we get user input?
# how to check if user input is valid? fucking regex?
# if predetermined spots, check if user input matches with any of the spots?
# matches none? invalid input
# matches filled one? 

# def check_victory(row, column)
    # check if either player has three adjacent marks.
    # manually check for each of the eight victory possibilities?
    # check only for the victory possibilities that include the cell that was just filled in
    # if a3? check for a1a2a3, a3b3c3, and a3b2c1
    # is value for each the same? declare winner
    
    # keep an array with the values. check the corresponding row and column. manually check for diagonals?
# end

 def check_victory(row, col, mark)
        # check if other cells in row have same value
        row_cells = @cells.select {|cell| cell.row == row }
        if (row_cells.all? {|cell| cell.value == mark })
            return true
        elseif (col_cells.all? { |cell| cell.value == mark })
            return true
        elseif (diagonal1.all? { |cell| cell.value == mark })
            return true
        elseif (diagonal2.all? { |cell| cell.value == mark })
            return true
        end

        # check if other cells in column have same value
        col_cells = @cells.select {|cell| cell.col == col }
        

        # check if diagonals have same value
        diagonal1 = @cells.select{|cell| cell.name = "a1" || cell.name = "b2" || cell.name = "c3"}
        diagonal2 = @cells.select{|cell| cell.name = "a3" || cell.name = "b2" || cell.name = "c1"}

        
        
    end

     def check_victory(row, col, mark)
        # check if other cells in row have same value
        row_cells = @cells.select {|cell| cell.row == row }
        row_cells.all? {|cell| cell.value == mark }

        # check if other cells in column have same value
        col_cells = @cells.select {|cell| cell.col == col }
        col_cells.all? { |cell| cell.value == mark }

        # check if diagonals have same value
        diagonal1 = @cells.select{|cell| cell.name = "a1" || cell.name = "b2" || cell.name = "c3"}
        diagonal2 = @cells.select{|cell| cell.name = "a3" || cell.name = "b2" || cell.name = "c1"}

        diagonal1.all? { |cell| cell.value == mark }
        diagonal2.all? { |cell| cell.value == mark }
    end


    # def clear
    #     @cells = Cell.new("a1", " ", "a", 1),
    #     Cell.new("a2", " ", "a", 2),
    #     Cell.new("a3", " ", "a", 3),
    #     Cell.new("b1", " ", "b", 1),
    #     Cell.new("b2", " ", "b", 2),
    #     Cell.new("b3", " ", "b", 3),
    #     Cell.new("c1", " ", "c", 1),
    #     Cell.new("c2", " ", "c", 2),
    #     Cell.new("c3", " ", "c", 3)
    # end