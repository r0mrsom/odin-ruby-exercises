require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'
require_relative 'rook'
require_relative 'queen'

class King
  attr_accessor :old_location, :positions
  attr_reader :color

  MOVES = [
    [ 0,  1], [ 0, -1],
    [ 1,  0], [-1,  0],
    [ 1,  1], [ 1, -1],
    [-1,  1], [-1, -1] ]
  CASTLE = [[[0, -1], [0, -2]], [[0, 1], [0, 2]]]

  def initialize(color, old_location, positions = nil)
    @color = color
    @old_location = old_location
    @positions = positions == nil ? {} : positions.select { |key, value| !value[:piece].nil? }
  end

  def move(new_location)
    safe_squares = cells_not_checked || [] 
    return "VALID" if safe_squares.include?(new_location)
    "INVALID"
  end

  def list_of_moves
    cells_not_checked
  end

  def is_checkmate?
    cells_not_checked.empty? && is_check? && !can_threats_be_eliminated?
  end

  def is_stalemate?
    cells_not_checked.empty? && !is_check? && available_ally_moves.empty?
  end

  def is_check?
    enemies = enemy_classes
    enemies.any? do |enemy|
      if enemy.class == Pawn
        enemy.takes(self.old_location) == "VALID"
      elsif !enemy.class.nil?
        enemy.move(self.old_location) == "VALID"
      end
    end
  end

  def simple_move(new_location)
    r_diff = (new_location[0] - self.old_location[0]).abs
    c_diff = (new_location[1] - self.old_location[1]).abs
    
    (r_diff <= 1 && c_diff <= 1) && [r_diff, c_diff] != [0,0]
  end


  def castle_valid?(new_location)
    king_locations = CASTLE.map { |locations| [locations.last[0] + self.old_location[0], locations.last[1] + self.old_location[1]] }
    spaces_covered_by_king = CASTLE.map { |directions| directions.map { |locations| [locations[0] + self.old_location[0], locations[1] + self.old_location[1]] } }

    rooks = self.positions.select { |k, v| v[:piece] == "rook" && v[:color] == color && v[:moves] == 0}
    king = self.positions.select { |k, v| v[:piece] == 'king' && v[:color] == color && v[:moves] == 0}

    return false if rooks.empty? || king.empty?
    return false if !king_locations.include?(new_location)

    spaces_to_castle = spaces_covered_by_king.find { |locations| locations.include?(new_location) }

    are_spaces_in_check = spaces_to_castle.any? do |loc|
      enemy_classes.any? do |enemy|
        enemy.is_a?(Pawn) ? enemy.list_of_takes.include?(loc) : enemy.list_of_moves.include?(loc)
      end
    end

    ranges = rooks.map { |k, v| [self.old_location[1], k[1]].sort }

    result = []
    ranges.select { |pair| new_location[1].between?(*pair) }.each do |range|
      (range.min .. range.max).to_a.each { |columns| result << [new_location[0], columns]}
    end

    are_spaces_between_occupied = result[1...-1].any? { |locations| self.positions[locations] }

    !are_spaces_in_check && !is_check? && !are_spaces_between_occupied

  end

  private

  def valid_moves
    neighbors = []

    MOVES.each do |locations|
      r = self.old_location[0] + locations[0]
      c = self.old_location[1] + locations[1]
      
      piece_present_with_same_color = 
        !self.positions[[r, c]].nil? &&
        self.positions[[r, c]][:color] == self.color

      if r.between?(0, 7) && c.between?(0, 7)
        next if piece_present_with_same_color
        neighbors << [r, c]
      end
    end
    neighbors
  end

  def cells_not_checked
    return valid_moves if self.positions.nil? || self.positions.empty?

    enemies = enemy_classes
    neighbors = valid_moves

    result = check_checker(enemies, neighbors)

    safe_zone = []
    neighbors.each_with_index do |location, i|
      safe_zone << location if result[i] == false
    end

    safe_zone
  end

  def cells_causing_check
    enemy_classes.select do |enemy|
      if enemy.class == Pawn
        enemy.takes(self.old_location) == "VALID"
      else
        enemy.move(self.old_location) == "VALID"
      end
    end
  end

  def can_threats_be_eliminated?
    attackers = cells_causing_check
    attackers.all? do |enemies|
      same_classes.any? do |allies|
        if allies.class == Pawn
          allies.takes(enemies.old_location) == "VALID"
        else
          allies.move(enemies.old_location) == "VALID"
        end
      end
    end
  end

  def available_ally_moves
    moves = []
    same_classes.each do |piece|
      moves = moves + piece.list_of_moves
    end
    moves
  end

  def same_classes
    locations = self.positions.select do |key, value|
      value[:color] == self.color && key != self.old_location
    end
    convert_to_classes(locations)
  end

  def enemy_classes
    locations = self.positions.select do |key, value|
      value[:color] != self.color && key != self.old_location
    end
    convert_to_classes(locations)
  end

  def check_checker(enemies, neighbors)
    neighbors.map do |movements|
      enemies.any? do |enemy_classes|
        temp_positions = self.positions.dup
        temp_positions.delete(self.old_location)
        temp_positions[movements] = {color: self.color, piece: 'king'}
        enemy_classes.positions = temp_positions

        is_valid =  if enemy_classes.is_a?(Pawn)
                      enemy_classes.takes(movements) == "VALID"
                    elsif enemy_classes.is_a?(King)
                      enemy_classes.simple_move(movements)
                    else
                      enemy_classes.move(movements) == "VALID"
                    end
        is_valid
      end
    end
  end

  def convert_to_classes(locations)
    locations.map do |key, value|
      case
      when value[:piece] == "pawn"
        Pawn.new(value[:color], key, value[:moves], self.positions)
      when value[:piece] == "knight"
        Knight.new(value[:color], key, self.positions)
      when value[:piece] == "bishop"
        Bishop.new(value[:color], key, self.positions)
      when value[:piece] == "rook"
        Rook.new(value[:color], key, self.positions)
      when value[:piece] == "queen"
        Queen.new(value[:color], key, self.positions)
      when value[:piece] == 'king'
        King.new(value[:color], key, self.positions)
      end
    end
  end
end