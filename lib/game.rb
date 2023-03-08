require "open-uri"
require_relative "./display"
require_relative "./game_logic"

class Game
  include Display
  include GameLogic

  def initialize
    @word = random_word_generation
    @used_letters = []
    @guesses_left = 6
    @guess = nil
    # GREETING
    game_loop
  end

  def game_loop
    # if save_exists? && (new_game != true)
    #   load(save_number)
    # end
    p @word
    loop do
      system("clear") || system("clr")
      puts "Guesses remaining: #{@guesses_left}"
      puts "#{guesses_remaining(@guesses_left)}\n"
      print "\t#{@used_letters.join(" ")}\n\n"
      puts "\t#{board_state} \n\n"
      break if word_guessed?
      user_guess
      unless @word.include?(@guess) && !letter_available?(@guess) # letter guessed
        @guesses_left -= 1
      end
    end
  end
end
