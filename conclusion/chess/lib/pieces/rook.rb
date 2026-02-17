class Rook
  attr_accessor :old_location, :new_location, :positions
  attr_reader :color

  MOVES = [
    [[ 1,  0], [ 2,  0], [ 3,  0], [ 4,  0], [ 5,  0], [ 6,  0], [ 7,  0]],
    [[-1,  0], [-2,  0], [-3,  0], [-4,  0], [-5,  0], [-6,  0], [-7,  0]],
    [[ 0,  1], [ 0,  2], [ 0,  3], [ 0,  4], [ 0,  5], [ 0,  6], [ 0,  7]],
    [[ 0, -1], [ 0, -2], [ 0, -3], [ 0, -4], [ 0, -5], [ 0, -6], [ 0, -7]] ]

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
    MOVES.each do |direction|
      direction.each do |locations|
        r = locations[0] + self.old_location[0]
        c = locations[1] + self.old_location[1]
        next if moves.include?([r, c])
        break unless r.between?(0, 7) && c.between?(0,7)
        if !self.positions.nil? && !self.positions[[r, c]].nil?
          moves << [r, c] if self.positions[[r, c]][:color] != self.color
          break
        end
        moves << [r, c]
      end
    end
    moves
  end
end