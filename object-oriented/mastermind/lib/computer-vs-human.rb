require_relative "input-vs-guess"
require_relative "color-starter"
require_relative "color-display"
require_relative "mastermind-input"

class ComputerToGuess
  COLOR = ["red", "yellow", "green", "blue"].freeze

  def initialize(human, computer)
    @human = human
    @computer = computer
    @guess = MastermindInput.create
    @input = []
    #@input = ["red", "yellow", "blue", "green"]
    for i in (0..3) do
      @input[i] = COLOR[rand(4).floor]
    end
  end

  def compare
    InputVSGuess.result(@input, @guess)
  end

  def changeFalse
    [0, 1, 2, 3].sample(compare.count(false)).each { |index| @input[index] = COLOR.reject{ |element| element == @input[index] }.sample }
  end

  def changeWhite
    old =  [0, 1, 2, 3].sample(compare.count("white") + compare.count(false))
    new = old.shuffle
    while new == old
      new = new.shuffle
    end
      
    if old.length
      oldInput = @input.dup
        for i in 0..(old.length - 1)
          @input[old[i]] = oldInput[new[i]]
        end
    end
  end

  def play
    trial = 1
    puts trial.to_s.rjust(2, '0') + "  |  " + ColorDisplay.display(@input) + "  |  " + ColorDisplay.display(compare)

    until compare.all?("black") || trial > 11
      
      if compare.any?("white")
        changeWhite
      end

      if compare.any?(false)
        changeFalse
      end

      trial += 1
      puts trial.to_s.rjust(2, '0') + "  |  " + ColorDisplay.display(@input) + "  |  " + ColorDisplay.display(compare)
    end

    if compare.all?("black")
      puts
      puts "COMPUTER WINS!"
      puts "Computer guessed the answer in #{trial} tries."
      return :computer
    end

    if trial >= 12
      puts
      puts "HUMAN WINS!"
      puts "Computer was unable to guess: " + ColorDisplay.display(@guess)
      return :human
    end
  end

  def self.play(human, computer)
    new(human, computer).play
  end
         
end
