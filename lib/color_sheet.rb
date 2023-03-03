# This contains a list of colors and background colors.
# MASTERMIND arrays are specificially for use in the Mastermind game
module ColorSheet
  def code_colors(number)
    {
      "1" => "\e[101m 1 ", # pink
      "2" => "\e[41m 2 ",  # red
      "3" => "\e[42m 3 ",  # green
      "4" => "\e[43m 4 ",  # yellow
      "5" => "\e[44m 5 ",  # blue
      "6" => "\e[45m 6 "   # purple
    }[number] + "\e[0m"
  end

  def hint_colors(hint)
    {
      "?" => "\e[30m \u25CF \e[0m",
      "!" => "\e[32m \u25CF \e[0m"
    }[hint]
  end

  def colored_numbers(number_array)
    number_array.map { |number| code_colors(number.to_s) }.join(" ")
  end
end

# method to change guesses a certain color. Green if correct, grey if incorrect.
# method will take the letter argument, apply the "check if correct" method to it.
# if it returns true, it is given the green ANSI color (42m)
# if false it is given
