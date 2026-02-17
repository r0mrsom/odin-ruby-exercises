require_relative 'bishop'
require_relative 'rook'

class Queen
  attr_accessor :old_location, :positions
  attr_reader :color

  def initialize(color, old_location, positions = nil)
    @color = color
    @old_location = old_location
    @positions = positions == nil ? {} : positions.select { |key, value| !value[:piece].nil? }
  end

  def move(new_location)
    (Rook.new(color, old_location, positions).move(new_location) == "VALID" ||
    Bishop.new(color, old_location, positions).move(new_location) == "VALID") ? "VALID" : "INVALID"
  end
  
  def list_of_moves
    result = []
    result = result + Rook.new(color, old_location, positions).list_of_moves
    result = result + Bishop.new(color, old_location, positions).list_of_moves
    result
  end
end