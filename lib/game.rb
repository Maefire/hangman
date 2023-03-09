require_relative "game_logic"
require_relative "display"

class Game
  include Display
  include GameLogic

  # introduction. Does player want to load a game or start anew?
  def play
    puts GREETING
    check_choice = new_or_load?
    SinglePlayer.new.game_loop if check_choice == "1"
    saved_game_list if check_choice == "2"
  end

  # player chooses new or save via numerical choice.
  def new_or_load?
    loop do
      user_input = gets.chomp.downcase
      return user_input if %w[1 2].include?(user_input)
      puts "Please enter \"1\" to start a new game, or \"2\" to load a saved game"
    end
  end
end
