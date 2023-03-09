module Display
  GREETING = <<~HEREDOC
    Hangman is a guessing game for two or more players. One player thinks of a word, phrase or
    sentence and the other(s) tries to guess it by suggesting letters within a certain number of
    guesses. Originally a Paper-and-pencil game, there are now electronic versions.
    
    In this version of Hangman, you are put against an AI opponent. You are given only
    6 rounds to guess the word, which will range from 5-12 letters in length. At any time during
    the game, you may enter "save", and your game will create a time-stamped file for you.
    \e[91m(Note: resuming a game will result in your initial save file being deleted.)\e[0m


      Press the number corresponding to your option:

      1. New Game

      2. Load Game
    
  HEREDOC

  SAVEDMESSAGE = <<~HEREDOC
    Please select the file from the list below:



  HEREDOC

  # generates board on each loop, showing correct letter or if unknown, it shows "_"
  def board_state
    @word.chars.map do |char|
      if @used_letters.include?(char)
        char
      else
        "_"
      end
    end.join(" ")
  end

  # ASCII art is a pain. I'd pay to have someone else do it.
  def guesses_remaining(guesses_left)
    case guesses_left
    when 6
      %q(
    _________
    |/      |
    ||
    ||
    ||
    ||
    ||________
    ||\_-_-_-_|
  )
    when 5
      %q{
    _________
    |/      |
    ||     (_)
    ||
    ||
    ||
    ||________
    |\_-_-_-_-|
  }
    when 4
      %q{
    _________
    |/      |
    ||     (_)
    ||      |
    ||      |
    ||
    ||________
    |\_-_-_-_-|
  }
    when 3
      %q{
    _________
    |/      |
    ||     (_)
    ||     \|
    ||      |
    ||
    ||________
    |\_-_-_-_-|
  }
    when 2
      %q{
    _________
    |/      |
    ||     (_)
    ||     \|/
    ||      |
    ||     /
    ||________
    |\_-_-_-_-|
  }
    when 1
      %q{
    _________
    |/      |
    ||     (_)
    ||     \|/
    ||      |
    ||     / \
    ||________
    |\_-_-_-_-|
  }
    when 0
      %q{
    _________
    |/      |
    ||      |
    ||     (x)
    ||     \|/
    ||      |
    ||_____/_\
    |\_-_-_-_-|
  }
    end
  end
end
