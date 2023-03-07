require "open-uri"
require_relative "./display"

class Game
  include Display

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
      p board_state
      puts "Guesses remaining: #{@guesses_left}"
      break if word_guessed?
      print "#{@used_letters.join(" ")}\n\n\n"
      user_guess
      unless @word.include?(@guess) && @used_letters.include?(@guess) # letter guessed
        @guesses_left -= 1
      end
    end
  end

  # #####TODO########
  # Do we need letter available method? Could just check @used_letters.inlucde?
  # They are the same-ish size.
  # #####TODO########

  def user_guess
    @guess = gets.chomp.downcase.delete("^a-z").to_s
    if @guess.length == 1 && !letter_available?(@guess)
      @used_letters << @guess
    elsif letter_available?(@guess)
      puts "Letter has been used. Please choose another letter."
      user_guess
    else
      puts "Error! Please only guess 1 letter between \"a\" through \"z\""
      user_guess
    end
  end

  def word_guessed?
    if @word.chars.all? { |char| @used_letters.include?(char) }
      puts "Congratulations! You win!"
      true
    elsif @guesses_left == 0
      puts "You lost! The word was #{@word}"
      true
    end
  end

  def to_s
    "Word: #{@word},\n Used: #{@used_letters},\n Guess left: #{@guesses_left}"
  end

  def letter_available?(guess)
    @used_letters.include?(guess)
  end

  def random_word_generation
    File.readlines("dictionary.txt").sample.chomp
  end
end
