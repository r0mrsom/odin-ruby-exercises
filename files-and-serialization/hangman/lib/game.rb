require_relative 'brains/character-input'
require_relative 'brains/result'
require_relative 'brains/random-word-getter'
require_relative 'brains/win-or-lose'
require_relative 'display/letters-used-display'
require_relative 'display/stickman-display'
require_relative 'display/word-to-guess-display'

class Gameplay
  
  def initialize()
    @charInput = []
    @charUsed = []
    @word = WordToGuess.new.split("")
    #@word = "apple".split("") --> added for testing purposes
    @wrongGuess = 0
    @win = false
    @lose = false
  end
  

  def wrongGuessCounter
    if @charUsed.length == 0
      @wrongGuess = 0
    else
      @wrongGuess =  @charUsed.count { |char_guess| !@word.include?(char_guess)}
    end
  end

  def winOrLoseChecker
    
    checker = resultChecker
    @win = GameLogic.win?(@wrongGuess, checker)
    @lose = GameLogic.lose?(@wrongGuess, checker)
    
  end

  def resultChecker
    Result.new(@word, @charUsed).checker
  end

  def display
    puts "\e[H\e[2J"
    LettersUsed.alphabet(@charUsed)
    LettersUsed.inputs(@charUsed)
    @win ? StickManSaved.display(@win) : StickMan.display(@wrongGuess)
    if @lose
      puts @word.join(" ").upcase.center(103)
      puts
    else
      WordToGuessDisplay.screen(@word, @charUsed)
    end
  end

  def start

    until (@win || @lose) == true

      display

      @charInput = CharacterInput.new
      @charUsed.push(@charInput)

      wrongGuessCounter
      winOrLoseChecker

    end

    if @win  == true
      winning
    elsif @lose == true
      losing
    end
  end

  def losing
    display
    puts "\e[41;1m#{"GAME OVER! RIP STICKMAN".center(103)}\e[0m"
  end

  def winning
    display
    puts "\e[102;1m#{"CONGRATULATION! YOU SAVED STICKMAN!".center(103)}\e[0m"
  end

end