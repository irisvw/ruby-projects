# Hangman!
class Game
  def initialize
    @dictionary = File.readlines('dictionary.txt', chomp: true)
    @secret_word = ''
    @guesses = []
    @remaining_letters = ('a'..'z').to_a
    @remaining_guesses = 6
    @gameloop = true
  end

  def set_secret_word
    @secret_word = @dictionary.select { |element| element.length.between?(4, 13) }.sample
    @progress = Array.new(@secret_word.length, '_')
  end

  def play
    set_secret_word
    while @gameloop
      letter = guess
      evaluate_guess(letter)
      display_results
      check_victory
      check_loss
    end
  end

  def evaluate_guess(letter)
    if @secret_word.include?(letter)
      arr = @secret_word.split('')
      occurrences = arr.each_with_index.filter_map { |element, index| index if element == letter }
      occurrences.each { |index| @progress[index] = letter }
    else
      @remaining_guesses -= 1
      @guesses << letter
    end
  end

  def display_results
    puts @progress.join(' ')
    puts "Remaining guesses: #{@remaining_guesses}"
    puts "Incorrect guesses: #{@guesses.sort}"
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

  def check_loss
    return unless @remaining_guesses <= 0

    puts 'No more guesses remaining. You lose.'
    @gameloop = false
  end

  def check_victory
    return unless @secret_word == @progress.join('')

    puts 'Congratulations! You guessed the secret word.'
    @gameloop = false
  end
end

game = Game.new
game.play
