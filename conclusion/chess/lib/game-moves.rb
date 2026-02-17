require_relative 'center-text'

class GameMoves
  attr_accessor :moves
  
  def initialize
    @moves = []
  end

  def make_move(notation)
    return self.moves[0] = ["1. " + notation] if self.moves.empty?
    if self.moves.last.length == 1
      self.moves.last << notation
    else
      self.moves[self.moves.length] = [(self.moves.length + 1).to_s + ". " + notation]
    end
  end

  def all_moves
    puts CenterText.new("MOVES MADE SO FAR:")
    puts
    return "No moves made yet" if self.moves.empty?
    moves_putter = []
    rows = ((self.moves.length) / 4.to_f).ceil
    
    (0...rows*4).to_a.each do |index|
      row_number = index % rows
      moves_putter[row_number] ||= []

      moves_putter[row_number] = 
          moves_putter[row_number] <<
          if self.moves[index].nil? 
            ("").ljust(15)
          else
            self.moves[index].join(" ").ljust(15)
          end

    end
    
    display_all_moves(moves_putter)
  end

  def display_all_moves(moves_putter)
    moves_putter.each do |rows|
      puts CenterText.new(rows.join("    "))
    end
  end
end

# input_test = GameMoves.new
# # 1. d4 Nf6
# input_test.make_move("d4")
# input_test.make_move("Nf6")

# # 2. c4 e6
# input_test.make_move("c4")
# input_test.make_move("e6")

# # 3. Nc3 Bb4
# input_test.make_move("Nc3")
# input_test.make_move("Bb4")

# # 4. e3 O-O
# input_test.make_move("e3")
# input_test.make_move("O-O")

# # 5. Bd3 c5
# input_test.make_move("Bd3")
# input_test.make_move("c5")
# p input_test.moves