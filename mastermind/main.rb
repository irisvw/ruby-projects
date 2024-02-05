# MASTERMIND
# Computer uses the Swaszek strategy, same first guess every time.

colored_code_pegs = %w[red orange yellow green blue purple]
numbered_code_pegs = [1, 2, 3, 4, 5, 6]

code_pegs = colored_code_pegs

class Game
  def initialize(pegs, codebreaker, codemaker)
    @pegs = pegs
    @codebreaker = codebreaker
    @codemaker = codemaker
  end

  def play
    result = 'first guess'
    guesses = max_guesses
    secret_code = @codemaker.generate_code(@pegs)
    loop do
      guess = @codebreaker.guess(result)
      guesses -= 1
      result = @codemaker.tell_results(secret_code, guess, guesses)
      break if result == 'end'
    end
  end

  def max_guesses
    @codebreaker.max_guesses
  end
end

class Player
  attr_reader :max_guesses

  def initialize(max_guesses, pegs)
    @max_guesses = max_guesses
    @pegs = pegs
  end
end

class ComputerPlayer < Player
  @@remaining_candidates = nil

  def generate_code(pegs)
    guesses = max_guesses
    secret_code = []
    4.times { |i| secret_code[i] = pegs.sample }
    puts "I've generated a secret code. Start guessing! You have #{guesses} guesses left."
    secret_code
  end

  def all_solutions
    @pegs.repeated_permutation(4).to_a
  end

  def first_guess
    [@pegs[0], @pegs[0], @pegs[1], @pegs[1]]
  end

  def guess(result)
    if result == 'first guess'
      guess = first_guess
    else
      guesses = eliminate(result)
      guess = guesses.sample
    end

    if guesses == []
      puts "No more possible solutions. This shouldn't have happened. Either I messed up or you messed up. And I don't mess up."
    else
      puts "My guess is #{guess}."
    end

    guess
  end

  def compare(code, guess)
    correct_color = 0
    code_array = code.reject.with_index { |element, i| element == guess[i] }
    guess_array = guess.reject.with_index { |element, i| element == code[i] }
    correct_position = 4 - code_array.length

    guess_array.each do |element|
      if code_array.include?(element)
        correct_color += 1
        code_array.delete_at(code_array.index(element))
      end
    end

    { cor_pos: correct_position, cor_col: correct_color, guess: guess }
  end

  def eliminate(current_result)
    @@remaining_candidates ||= all_solutions
    guess = current_result[:guess]
    all_results = @@remaining_candidates.map { |candidate| compare(guess, candidate) }
    @@remaining_candidates = all_results.filter_map do |result|
      result[:guess] if (result[:cor_col] == current_result[:cor_col]) && (result[:cor_pos] == current_result[:cor_pos])
    end
  end

  def tell_results(code, guess, guesses)
    result = compare(code, guess)
    puts "#{result[:cor_pos]} of your guesses are the right value and the right position. \n#{result[:cor_col]} of your guesses are the right value, but the wrong position."
    if result[:cor_pos] == 4
      puts "Congratulations! You guessed correctly with #{max_guesses - guesses} guess(es)."
      return 'end'
    end

    if guesses.zero?
      puts "You have #{guesses} guesses left. You lose. My secret code was #{code}."
      'end'
    else
      puts "You have #{guesses} guesses left.\n"
    end
  end
end

class HumanPlayer < Player
  def generate_code(_pegs)
    puts 'What would you like the code to be?'
    secret_code = gets.chomp.downcase.split(' ')
  end

  def tell_results(_code, guess, guesses)
    puts 'How many did I get in the right value and position?'
    cor_pos = gets.chomp.to_i
    puts 'How many did I get in the right value, but wrong position?'
    cor_col = gets.chomp.to_i

    if cor_pos == 4
      puts "Nice. I'm so good at this game. I solved it in #{max_guesses - guesses} guess(es)."
      return 'end'
    else
      puts "Alright. I'm thinking of my next guess. I have #{guesses} guesses left."
    end

    { cor_pos: cor_pos, cor_col: cor_col, guess: guess }
  end

  def guess(_result)
    gets.chomp.downcase.split(' ')
  end
end

init = true
while init
  puts 'Would you like to be the codebreaker or the codemaker?'
  input = gets.chomp.downcase
  if input == 'codebreaker'
    init = false
    codemaker = ComputerPlayer.new(12, code_pegs)
    codebreaker = HumanPlayer.new(12, code_pegs)
    game = Game.new(code_pegs, codebreaker, codemaker)
    game.play
  elsif input == 'codemaker'
    init = false
    codebreaker = ComputerPlayer.new(12, code_pegs)
    codemaker = HumanPlayer.new(12, code_pegs)
    game = Game.new(code_pegs, codebreaker, codemaker)
    game.play
  else
    puts 'Invalid input.'
  end
end
