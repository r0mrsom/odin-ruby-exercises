require 'io/console'
require_relative 'center-text'
require_relative 'cell'

class UpdateBoard
  CHECKERED = {0 => 'bg_white', 1 => 'bg_gray', 2 => 'bg_red'}
  PIECES = {
    'king' => " +K+ ",
    'queen' => " ^Q^ ",
    'bishop' => " (B) ",
    'rook' => " [R] ",
    'knight' => " <N> ",
    'pawn' => "  o  " }
  
  attr_accessor :positions

  def initialize(positions = nil)
    @positions = positions || {
      [0, 0] => {color: 'black', piece: 'rook', moves: 0, active: false},
      [0, 1] => {color: 'black', piece: 'knight', moves: 0, active: false},
      [0, 2] => {color: 'black', piece: 'bishop', moves: 0, active: false},
      [0, 3] => {color: 'black', piece: 'queen', moves: 0, active: false},
      [0, 4] => {color: 'black', piece: 'king', moves: 0, end_moves: 0, active: false},
      [0, 5] => {color: 'black', piece: 'bishop', moves: 0, active: false},
      [0, 6] => {color: 'black', piece: 'knight', moves: 0, active: false},
      [0, 7] => {color: 'black', piece: 'rook', moves: 0, active: false},
      [1, 0] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 1] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 2] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 3] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 4] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 5] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 6] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [1, 7] => {color: 'black', piece: 'pawn', moves: 0, active: false},
      [6, 0] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 1] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 2] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 3] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 4] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 5] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 6] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [6, 7] => {color: 'white', piece: 'pawn', moves: 0, active: false},
      [7, 0] => {color: 'white', piece: 'rook', moves: 0, active: false},
      [7, 1] => {color: 'white', piece: 'knight', moves: 0, active: false},
      [7, 2] => {color: 'white', piece: 'bishop', moves: 0, active: false},
      [7, 3] => {color: 'white', piece: 'queen', moves: 0, active: false},
      [7, 4] => {color: 'white', piece: 'king', moves: 0, end_moves: 0, active: false},
      [7, 5] => {color: 'white', piece: 'bishop', moves: 0, active: false},
      [7, 6] => {color: 'white', piece: 'knight', moves: 0, active: false},
      [7, 7] => {color: 'white', piece: 'rook', moves: 0, active: false}, }
  end

  def row(*cells)
    cells.transpose.map { |line_parts| line_parts.join } .join("\n")
  end

  def grid_maker(current_positions = self.positions)
    (0..7).map do |r_idx|
      (0..7).map do |c_idx|
        piece = current_positions[[r_idx, c_idx]]
        bg    = CHECKERED[(r_idx + c_idx) % 2]

        if piece.nil?
          Cell.new(bg, bg, "     ")
        elsif piece[:active]
          bg_active = CHECKERED[2]
          piece[:piece].nil? ? 
            Cell.new(bg_active, bg_active, "     ") : 
            Cell.new(bg_active, piece[:color], PIECES[piece[:piece]])
        else
          Cell.new(bg, piece[:color], PIECES[piece[:piece]])
        end
      end
    end
  end

  def update_piece(old_location, new_location)
    return if self.positions[old_location].nil?
    self.positions[new_location] = self.positions.delete(old_location)
  end

  def display_board
    middle_board = grid_maker.map.with_index do |rows, i|
      rendered_rows = rows.map { |cells| cells.render }
      row_number = Cell.new('black', 'black', "  #{8 - i}  ").render
      row_content = [row_number, *rendered_rows, row_number]
      row(*row_content)
    end.join("\n")

    rendered_bottom = ('a'..'h').map { |columns| Cell.new('black', 'black', "  #{columns}  ").render }
    board_corner = Cell.new('black', 'black').render
    column_number = row(board_corner, *rendered_bottom, board_corner)

    full_board = [column_number, *middle_board, column_number]

    row(full_board)
  end

  def add_input(game_moves)
    last_game_moves = game_moves.length >= 54 ? game_moves.last(54).reverse : game_moves
    board = display_board.split("\n")

    last_game_moves.each_with_index do |entries, index|
      board[index % 27 + 2] = board[index % 27 + 2] + "   " + entries.join(" ").ljust(15)
    end

    puts board.join("\n")
  end
end