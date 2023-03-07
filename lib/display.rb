module Display
  GREETING = <<~HEREDOC
    welcome to Hangman. This is all sample text and place holders
    
  HEREDOC

  def board_state
    @word.chars.map do |char|
      if @used_letters.include?(char)
        char
      else
        "_"
      end
    end.join(" ")
  end

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
    ||_________
    ||\_-_-_-_-|
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
