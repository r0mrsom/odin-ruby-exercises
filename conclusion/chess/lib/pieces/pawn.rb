class Pawn
  attr_accessor :old_location, :new_location, :positions, :moves
  attr_reader :color

  TAKES = [[1, -1], [1, 1]]

  def initialize(color, old_location, moves = 0, positions = nil)
    @color = color
    @old_location = old_location
    @moves = moves
    @positions = positions == nil ? {} : positions.select { |key, value| !value[:piece].nil? }
  end

  def move(new_location)
    return "VALID" if valid_moves.include?(new_location) || valid_takes.include?(new_location)
    "INVALID"
  end

  def takes(new_location)
    return "VALID" if valid_takes.include?(new_location)
    "INVALID"
  end

  def list_of_moves
    valid_moves
  end

  def list_of_takes
    valid_takes
  end

  private

  def valid_moves
    valids = []
    mult = self.color == 'white' ? -1 : 1
    r, c = self.old_location

    one_move = [r + (1 * mult), c]
    if on_board(one_move) && positions[one_move].nil?
      valids << one_move

      two_move = [r + (2 * mult), c]
      if self.moves == 0 && on_board(two_move) && positions[two_move].nil?
        valids << two_move
      end
    end
    valids
  end

  def valid_takes
    valids = []
    mult = self.color == 'white' ? -1 : 1
    r, c = self.old_location
    
    TAKES.each do |diagonal|
      diagonal_take = [r + (diagonal[0] * mult), c + diagonal[1]]
      en_passant_square = [r, c + diagonal[1]]

      if on_board(diagonal_take) && 
          positions[diagonal_take] &&
          positions[diagonal_take][:color] != color
        valids << diagonal_take
      elsif on_board(en_passant_square) &&
          !positions[diagonal_take] &&
          positions[en_passant_square] &&
          positions[en_passant_square][:color] != color &&
          positions[en_passant_square][:piece] == 'pawn' &&
          positions[en_passant_square][:moves] == 1 &&
          positions[en_passant_square][:active] == true
        valids << diagonal_take
      end
    end
    valids
  end

  def on_board(loc)
    loc[0].between?(0, 7) && loc[1].between?(0, 7)
  end
end