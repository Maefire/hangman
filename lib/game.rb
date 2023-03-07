require "open-uri"
require_relative "./display"

class Game
  include Display

  def initialize
    @word = random_word_generation
    @used_letters = %w[a b c d e g h i j k l m n o p q r s t u v w x y z]
    @win_array = []
  end

  dictionary = URI.open("dictionary.txt", "r")

  def user_guess
    p @word
    user_input = gets.chomp.downcase.delete("^a-z").to_s
    if user_input.length == 1 && !letter_available?(user_input)
      match_against_word(user_input)
      @used_letters << user_input
      word_guessed?
    else
      puts "Error! Please only guess 1 letter between a-z"

      puts "guess: #{user_input} letters: #{@used_letters}"
      user_guess
    end
  end

  ####################
  ###   TO DO        ###
  ### check for dupes ###
  ###   TO DO        ###
  ####################
  def word_guessed?
    @used_letters.each do |letter|
      if @word.include?(letter)
        @win_array << letter
      end
    end
    puts @win_array.sort == @word.chars.sort
    puts "win_array: #{@win_array},#{@win_array.length} word:#{@word},#{@word.length}"
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

#################################################################################
### Board state can be an empty array. When game starts, have the array populate.
### The array will match the @word.length, so it will be an array of "_"s
### When letter matches @word, then corresponding "_" will become letter
### would not need to check for duplicates, due to how hangman works.
### instead, just make sure each one does change. match_against_word()? could
### be used. if true board_array[i] = user_input ?
#################################################################################
