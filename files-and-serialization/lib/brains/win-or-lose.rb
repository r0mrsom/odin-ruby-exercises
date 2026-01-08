require_relative 'random-word-getter'
require_relative 'character-input'

class GameLogic

  def initialize(wrongGuess, checker)
    @wrongGuess = wrongGuess
    @checker = checker
  end

  def win?
    if @wrongGuess == 0 && @checker.length == 0
      false
    else
      @checker.all?(true) && @wrongGuess <= 6
    end
  end

  def lose?
    @checker.any?(false) && @wrongGuess == 6
  end

  def self.win?(wrongGuess, checker)
    new(wrongGuess, checker).win?
  end

  def self.lose?(wrongGuess, checker)
    new(wrongGuess, checker).lose?
  end

end

#p GameLogic.win?(6, [true, false, false, false])
#p GameLogic.lose?(6, [true, false, false, false])