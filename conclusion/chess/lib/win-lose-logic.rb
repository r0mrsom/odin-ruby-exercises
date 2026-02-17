require_relative 'pieces/king'
require_relative 'board'
require_relative 'game-moves'
require_relative 'move-parser'
require 'io/console'

class WinOrLose
  attr_accessor :positions, :player, :history
  
  def initialize(positions, player, history = nil)
    @positions = positions
    @player = player # The player we are currently evaluating
    @history = history
  end

  # Helper to get the color of the player being evaluated
  def current_color
    @player == 1 ? 'white' : 'black'
  end

  # Is the current player's King in checkmate?
  def win?
    king_pos = find_king(current_color)
    return false unless king_pos
    King.new(current_color, king_pos, self.positions).is_checkmate?
  end

  # Is the current player's King in check?
  def check?
    king_pos = find_king(current_color)
    return false unless king_pos
    King.new(current_color, king_pos, self.positions).is_check?
  end

  def stalemate?
    stalemate_by_no_moves? || stalemate_by_insufficient_material? || 
    stalemate_by_threefold? || stalemate_by_50_moves?
  end

  private

  def find_king(color)
    self.positions.find { |_, v| v[:piece] == 'king' && v[:color] == color }&.first
  end

  def stalemate_by_no_moves?
    king_pos = find_king(current_color)
    return false unless king_pos
    King.new(current_color, king_pos, self.positions).is_stalemate?
  end

  def stalemate_by_insufficient_material?
    all_pieces = self.positions.values.filter_map { |v| v[:piece] }
    return true if all_pieces.count == 2
    
    if all_pieces.count == 3
      minor_pieces = ['bishop', 'knight']
      return all_pieces.any? { |p| minor_pieces.include?(p) }
    end
    false
  end

  def stalemate_by_threefold?
    return false if history.nil?
    history.threefold?
  end

  def stalemate_by_50_moves?
    return false if history.nil?
    history.fifty_moves?
  end
end