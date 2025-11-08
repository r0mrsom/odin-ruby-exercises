require_relative 'display'
require_relative 'input-change'
require_relative 'win-checker'

class TicTacToe
  def initialize
    @board = { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9" }
    @acc = []
  end

  def play
    ScreenPrint.printScreen(@board)

    while XorO.promptInput(@acc).all?(false)
      ChangeInput.inputChanger(@board, @acc)
      ScreenPrint.printScreen(@board)

      if game_over?
        puts "Nobody won."
        puts "GAME OVER"
        return
      end
    end

    announce_winner
  end

  private

  def game_over?
    !@board.any? { |key, value| key == value.to_i }
  end

  def announce_winner
    result = XorO.promptInput(@acc)
    if result[0]
      puts "X WINS!"
      puts "CONGRATULATIONS"
    elsif result[1]
      puts "O WINS!"
      puts "CONGRATULATIONS"
    end
  end

  def self.play
    new().play
  end
end