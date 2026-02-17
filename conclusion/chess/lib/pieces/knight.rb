class Knight
  attr_accessor :old_location, :positions
  attr_reader :color

  MOVES = [
    [ 1,  2], [ 1, -2],
    [ 2,  1], [ 2, -1],
    [-1,  2], [-1, -2],
    [-2,  1], [-2, -1] ]

  def initialize(color, old_location, positions = nil)
    @color = color
    @old_location = old_location
    @positions = positions == nil ? {} : positions.select { |key, value| !value[:piece].nil? }
  end

  def move(new_location)
    return "VALID" if valid_moves.include?(new_location)
    "INVALID"
  end

  def list_of_moves
    valid_moves
  end

  private

  def valid_moves
    moves = []
    MOVES.each do |locations|
      r = locations[0] + self.old_location[0]
      c = locations[1] + self.old_location[1]

      piece_present_with_same_color = 
        !self.positions[[r, c]].nil? &&
        self.positions[[r, c]][:color] == self.color

      if r.between?(0, 7) && c.between?(0, 7)
        next if piece_present_with_same_color
        moves << [r, c]
      end
    end
    moves
  end
end