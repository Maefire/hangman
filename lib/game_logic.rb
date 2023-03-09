require "yaml"
require_relative "display"

# #################################################################### #
# ######   This is where all the magic happens.                 ###### #
# ######   User input, game save/load, guess randomly generated,###### #
# ######   win condition checks, etc...                         ###### #
########################################################################
module GameLogic
  include Display

  # get user input
  def user_guess
    puts "Take a guess or enter \"save\" to save your current game."
    @guess = gets.chomp.delete("^a-z").downcase.to_s
    if @guess.length == 1 && letter_available?(@guess)
      @used_letters << @guess
    elsif !letter_available?(@guess)
      puts "Letter has been used. Please choose another letter."
      user_guess
    elsif @guess == "save"
      save_game
    else
      puts "Error! Please only guess 1 letter between \"a\" through \"z\""
      user_guess
    end
  end

  # checks for game over
  def word_guessed?
    if @word.chars.all? { |char| @used_letters.include?(char) }
      puts "Congratulations! You win!"
      try_again?
    elsif @guesses_left == 0
      puts "You lost! The word was #{@word}"
      try_again?
    end
  end

  # checks for availability of letter
  def letter_available?(guess)
    return true unless @used_letters.include?(guess)
  end

  # Check if player wants to continue a new game, or quit
  def try_again?
    puts 'New Game? Enter "Y" to continue, or any other key to quit.'
    new_game = gets.chomp.downcase
    if %w[y yes].include?(new_game)
      Game.new.play
    else
      puts "Thank you for playing!"
    end
    true
  end

  # loads dictionary, then randomly samples a word - the \n
  def random_word_generation
    File.readlines("dictionary.txt").sample.chomp
  end

  # saves game with incrementing file numbers. Dumps the information
  # into a .yaml.
  def save_game
    Dir.mkdir("output") unless Dir.exist?("output")
    save_number = 1
    while File.exist?("output/save_#{save_number}.yaml")
      save_number += 1
    end
    file_name = "output/save_#{save_number}.yaml"
    game_state = {
      "word" => @word,
      "used_letters" => @used_letters,
      "guesses_left" => @guesses_left
    }
    File.open(file_name, "w") do |file|
      YAML.dump(game_state, file)
    end
    puts "Game saved!"
    try_again?
  end

  # loads a game, deletes original save file, then runs the game loop
  def load_game(save_number)
    file_name = "output/save_#{save_number}.yaml"
    puts game_state = YAML.safe_load(File.read(file_name))
    game = SinglePlayer.new
    game.word = game_state["word"]
    game.used_letters = game_state["used_letters"]
    game.guesses_left = game_state["guesses_left"]
    File.delete(file_name)
    game.game_loop
    game
  end

  # lists all saved games, numbers them, and shows the modification date.
  def saved_game_list
    puts SAVEDMESSAGE
    save_files = Dir.glob("output/save_*.yaml")
    if save_files.empty?
      puts "No saves located. Start a new game to continue."
      Game.new.play
    else
      save_files.each do |file|
        file_id = File.basename(file)[/\d/]
        file_name = File.basename(file, ".yaml")
        file_time = File.mtime(file).strftime("%d-%m-%Y at %R")
        puts "#{file_id}:\t\"#{file_name}\" created: #{file_time}"
      end
    end
    user_choice = gets.chomp
    unless save_files.any? { |file| File.basename(file)[/\d/] == user_choice }
      puts "Please choose a valid number from the list provided."
      saved_game_list
    end
    load_game(user_choice)
  end
end
