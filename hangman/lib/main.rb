require 'yaml'
require 'date'

# Hangman!
class Hangman
  def initialize(secret_word = '', progress = '', guesses = [], remaining_letters = ('a'..'z').to_a, remaining_guesses = 6)
    @dictionary = File.readlines('dictionary.txt', chomp: true)
    @secret_word = secret_word
    @progress = progress
    @guesses = guesses
    @remaining_letters = remaining_letters
    @remaining_guesses = remaining_guesses
    @gameloop = true
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

  def set_secret_word
    return unless @secret_word == ''

    @secret_word = @dictionary.select { |element| element.length.between?(4, 13) }.sample
    @progress = Array.new(@secret_word.length, '_')
    puts @progress.join(' ')
  end

  def guess
    loop do
      puts "Guess a letter (or enter 'save' to save the game)."
      input = gets.chomp.downcase

      if input.length == 1 && @remaining_letters.include?(input)
        @remaining_letters.delete(input)
        return input
      elsif input == 'save'
        save_game
        puts 'Save succesful!'
      else
        puts 'Invalid guess.'
      end
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

  def check_loss
    return unless @remaining_guesses <= 0

    puts "No more guesses remaining. You lose. The secret word was '#{@secret_word}'."
    @gameloop = false
  end

  def check_victory
    return unless @secret_word == @progress.join('')

    puts 'Congratulations! You guessed the secret word.'
    @gameloop = false
  end

  def save_game
    data = YAML.dump({
      secret_word: @secret_word,
      progress: @progress,
      guesses: @guesses,
      remaining_letters: @remaining_letters,
      remaining_guesses: @remaining_guesses
      })

    datetime = Time.now.strftime("%Y%m%d_%H%M")
    Dir.mkdir('saved') unless Dir.exist?('saved')
    File.open("saved/#{datetime}.txt", 'w') do |f|
      f.write(data)
    end
  end
end

def setup
  puts 'Welcome to Hangman! Entering any key will start a new game, while entering LOAD will display your saved games.'
  input = gets.chomp.downcase

  if input == 'load'
    get_save
  else
    new_game
  end
end

def load_game(file)
  data = YAML.load_file(file)
  game = Hangman.new(data[:secret_word], data[:progress], data[:guesses], data[:remaining_letters], data[:remaining_guesses])
  game.display_results
  game.play
end

def get_save
  puts 'Saved games:'
  list = {}
  Dir.glob('saved/*.txt').each_with_index {|save, index| list[index] = save }
  if list == {}
    puts 'No saved games found. Starting a new one!'
    new_game
    return
  end

  list.each { |index, save| puts "#{index + 1}: #{File.basename(save, ".txt")}"}
  puts 'Which save would you like to load?'
  input = gets.chomp.to_i

  while (list.has_key?(input - 1) == false)
    puts 'Invalid input.'
    input = gets.chomp.to_i
  end

  load_game(list[input - 1])
end

def new_game
  game = Hangman.new
  game.play
end

setup