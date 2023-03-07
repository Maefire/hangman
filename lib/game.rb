require "open-uri"
require_relative "./display"

class Game
  include Display

  def initialize
    @word = random_word_generation
    @used_letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @guesses_left = 6
  end

  def user_guess
    p @word # remove #
    ##################
    user_input = gets.chomp.downcase.delete("^a-z").to_s
    if user_input.length == 1 && !letter_available?(user_input)
      match_against_word(user_input)
      @used_letters << user_input
      word_guessed?
    else
      puts "Error! Please only guess 1 letter between \"a\" through \"z\""

      puts "guess: #{user_input} letters: #{@used_letters}"
      user_guess
    end
  end

  def word_guessed?
    if @word.chars.all? { |char| @used_letters.include?(char) }
      puts "Congratulations! You win!"
    elsif @guesses_left == 0
      puts "You lost! The word was #{@word}"
    end
  end

  def to_s
    "Word: #{@word},\n Used: #{@used_letters},\n Round: #{@guesses_left}"
  end

  def letter_available?(guess)
    @used_letters.include?(guess)
  end

  def match_against_word(guess)
    @word.include?(guess)
  end

  def random_word_generation
    File.readlines("dictionary.txt").sample.chomp
  end
end
