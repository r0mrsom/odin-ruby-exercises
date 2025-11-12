require_relative 'color-starter'
require_relative 'input-vs-guess'
require_relative 'mastermind-input'
require_relative 'color-display'

class HumanToGuess

  def initialize(human, computer)
    @human = human
    @computer = computer
  end

  def play
    trial = 1
    guess = ColorGenerator.create
    input = MastermindInput.create
    result = InputVSGuess.result(input, guess)
    puts trial.to_s.rjust(2, '0')  + "  |  " + ColorDisplay.display(input) + "  |  " + ColorDisplay.display(result)
    
    until InputVSGuess.result(input, guess).all?("black") || trial > 11
      input = MastermindInput.create
      result = InputVSGuess.result(input, guess)
      trial += 1
      puts trial.to_s.rjust(2, '0')  + "  |  " + ColorDisplay.display(input) + "  |  " + ColorDisplay.display(result)
    end

    if InputVSGuess.result(input, guess).all?("black")
      puts
      puts "HUMAN WINS!"
      puts "You guessed the answer in #{trial} tries."
      return :human
    end

    if trial >= 12
      puts
      puts "COMPUTER WINS!"
      puts "The correct answer is: " + ColorDisplay.display(guess)
      return :computer
    end

  end

  def self.play(human, computer)
    new(human, computer).play
  end
end
