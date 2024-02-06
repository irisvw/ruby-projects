class Game
  def initialize
    @dictionary = File.readlines('dictionary.txt', chomp: true)
    @secret_word = ''
    @guesses = []
    @remaining_letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
  end

  def set_secret_word
    @secret_word = @dictionary.select { |element| element.length.between?(4, 13) }.sample
    @progress = Array.new(@secret_word.length, '_')
  end

  def play
    set_secret_word
    loop do
      letter = guess
      evaluate_guess(letter)
      # display results
    end
  end

  def evaluate_guess(letter)
    return "Doesn't occur." unless @secret_word.include?(letter)

    # take letter that player guessed
    # check if any letters in secret word match the letter, and on which positions
    arr = @secret_word.split('')
    occurrences = arr.each_with_index.filter_map { |element, index| index if element == letter }
    occurrences.each { |index| @progress[index] = letter }
    # update progress with correct letters
  end

  def display_results
    # puts progress
    # puts remaining guesses
    # puts incorrect letters
  end

  def guess
    loop do
      puts 'Guess a letter.'
      input = gets.chomp.downcase
      if input.length == 1 && @remaining_letters.include?(input)
        @remaining_letters.delete(input)
        return input
      else
        puts 'Invalid guess.'
      end
    end
  end
end

game = Game.new
game.play
