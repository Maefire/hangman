require_relative "./display"
require_relative "./game_logic"

class SinglePlayer
  include Display
  include GameLogic

  attr_accessor :used_letters, :guesses_left, :word

  # constructor is "overwritten" when game loaded
  def initialize
    @word = random_word_generation
    @used_letters = []
    @guesses_left = 6
    @guess = nil
  end

  # self clears each loop for a clean look.
  def game_loop
    loop do
      break if @guess == "save"
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
