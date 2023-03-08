module GameLogic
  def user_guess
    @guess = gets.chomp.downcase.delete("^a-z").to_s
    if @guess.length == 1 && letter_available?(@guess)
      @used_letters << @guess
    elsif !letter_available?(@guess)
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

  def letter_available?(guess)
    return true unless @used_letters.include?(guess)
  end

  def random_word_generation
    File.readlines("dictionary.txt").sample.chomp
  end
end
