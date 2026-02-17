class PositionsHistory
  attr_accessor :cache, :fifty_move_counter, :last_positions

  def initialize
    @cache = Hash.new(0)
    @fifty_move_counter = 0
    @last_positions = nil
  end

  def add(positions)
    pawn_moved = false
    piece_captured = false

    if @last_positions
      current_pieces = positions.select { |_, v| v[:active] }.count
      last_pieces = @last_positions.select { |_, v| v[:active] }.count
      piece_captured = current_pieces < last_pieces

      last_pawns = @last_positions.select { |_, v| v[:piece] == 'pawn' && v[:active] }
      curr_pawns = positions.select { |_, v| v[:piece] == 'pawn' && v[:active] }
      
      pawn_moved = last_pawns.keys.sort != curr_pawns.keys.sort
    end

    if pawn_moved || piece_captured
      @fifty_move_counter = 0
    else
      @fifty_move_counter += 1
    end

    board_id = positions.select { |_, v| v[:piece] && v[:active] }.map do |coords, data|
      [coords, data[:piece], data[:color]]
    end.sort.to_s

    @cache[board_id] += 1
    
    @last_positions = positions
  end

  def threefold?
    @cache.values.any? { |count| count >= 3 }
  end

  def fifty_moves?
    @fifty_move_counter >= 100
  end
end