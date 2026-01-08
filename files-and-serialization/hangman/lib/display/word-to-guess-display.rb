require_relative '../brains/result'

class WordToGuessDisplay
  def initialize(word, charUsed)
    @word = word
    @charUsed = charUsed
  end

  def screen
    checkResult = Result.new(@word, @charUsed)
    puts
    puts checkResult.blank_to_fill.join(" ").center(103)
    puts
  end

  def WordToGuessDisplay.screen(word, charUsed)
    new(word, charUsed).screen
  end
end

#WordToGuessDisplay.screen("apple".split(""),["a", "p"])