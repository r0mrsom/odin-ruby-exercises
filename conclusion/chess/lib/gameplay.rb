require_relative 'win-lose-logic'
require_relative 'history'
require 'io/console'

class Gameplay
  CLASSES = {'pawn' => Pawn, 'knight' => Knight, 'bishop' => Bishop, 'rook' => Rook, 'queen' => Queen, 'king' => King}

  attr_accessor :positions, :player, :input_consolidation, :history

  def initialize
    @positions = UpdateBoard.new.positions
    @player = 1
    @input_consolidation = GameMoves.new
    @history = PositionsHistory.new
  end

  def game
    while !WinOrLose.new(self.positions, self.player, self.history).win? && 
          !WinOrLose.new(self.positions, self.player, self.history).stalemate?
      result = make_move
      return if result == :quit
    end
    display_result
    press_any_key
  end

  def make_move
    castle_map = { 'o-o' => 6, 'oo' => 6, 'o-o-o' => 2, 'ooo' => 2 }
    input = prompt_display("Please input your move: ")
    
    loop do
      clean_input = input.downcase

      if 'moves'.start_with?(clean_input) && !clean_input.empty?
        system('clear') || system('cls')
        input_consolidation.all_moves
        press_any_key
        input = prompt_display("Please input your move: ")
        next
      end

      if 'tutorial'.start_with?(clean_input) || 'help'.start_with?(clean_input)
        Menu.new.tutorial
        press_any_key
        input = prompt_display("Please input your move: ")
        next
      end

      if 'quit'.start_with?(clean_input)
        prompt_display("Press any key to return to home. ")
        return :quit
      end

      if castle_map.key?(clean_input)
        target_col = castle_map[clean_input]
        if castle(target_col) == false
          input = prompt_display("Castling is invalid, please input another move: ")
          next
        end
        break
      end

      if MoveParser.matches_pattern?(input)
        result = update_positions(input)
        if result == "CHECK"
          input = prompt_display("King is under check / will be checked! Please input a valid move: ")
          next
        elsif result != "INVALID INPUT"
          break 
        end
      end
      
      input = prompt_display("Input invalid, please input your move: ")
    end

    self.history.add(self.positions)
    self.player *= -1
  end

  def update_positions(input)
    return "INVALID INPUT" if !MoveParser.matches_pattern?(input)

    piece = MoveParser.piece_identifer(input)
    coordinates = MoveParser.convert(input)
    location = coordinates[1]
    color = self.player == 1 ? 'white' : 'black'

    filtered_positions = self.positions.select do |k, v|
      if coordinates[0].nil?
        v[:piece] == piece && v[:color] == color
      elsif coordinates[0].is_a?(Numeric)
        v[:piece] == piece && v[:color] == color && k[1] == coordinates[0]
      elsif coordinates[0].is_a?(Array)
        v[:piece] == piece && v[:color] == color && k == coordinates[0]
      end
    end

    move_made = false
    under_check = false

    filtered_positions.each do |old_location, values|
      piece_class = CLASSES[piece]
      next if piece_class.nil?

      args = [color, old_location]
      args << values[:moves] if piece == 'pawn'
      args << self.positions
      piece_instance = piece_class.new(*args)
      next unless piece_instance.move(location) == "VALID"

      virtual_board = self.positions.dup
      virtual_board[location] = virtual_board.delete(old_location)
      
      if WinOrLose.new(virtual_board, self.player).check?
        under_check = true
        next
      end

      move_made = true
      execute_move(old_location, location, input)
      break
    end

    move_made ? self.positions :
      under_check ? "CHECK" : "INVALID INPUT"
  end

  def execute_move(old_location, location, input)
    enemy = self.player * -1
    color = self.player == 1 ? 'white' : 'black'
    back_rank = self.player == 1 ? 0 : 7

    self.positions.delete_if { |k, v| v[:piece].nil? }

    new_input = input.dup
    
    en_passant_pawn_present = self.positions.select { |k, v| k[0] == old_location[0] && v[:piece] == 'pawn' && v[:color] != color && v[:active] == true && v[:moves] == 1}
    is_en_passant_take = !en_passant_pawn_present.empty? && location[1] == en_passant_pawn_present.keys.first[1]

    is_promotion = self.positions[old_location][:piece] == 'pawn' && location[0] == back_rank

    self.positions.each { |_, v| v[:active] = false }

    if !self.positions[location].nil? && !self.positions[location][:piece].nil?
      new_input[-2..] = "X" + new_input[-2..]
    elsif is_en_passant_take == true
      new_input[-2..] = "X" + new_input[-2..] + "_en"
      self.positions.delete(en_passant_pawn_present.keys[0])
    end

    self.positions[location] = self.positions.delete(old_location)
    self.positions[location][:active] = true
    self.positions[location][:moves] += 1
    self.positions[old_location] = { active: true, piece: nil }

    if is_promotion
      promotion = prompt_display("Choose what piece to promote into (queen, rook, bishop, or knight): ")
      loop do
        case
        when 'queen'.start_with?(promotion.downcase) then
          self.positions[location][:piece] = 'queen'
          new_input = new_input + "=Q"
          break
        when 'rook'.start_with?(promotion.downcase) then
          self.positions[location][:piece] = 'rook'
          new_input = new_input + "=R"
          break
        when 'bishop'.start_with?(promotion.downcase) then
          self.positions[location][:piece] = 'bishop'
          new_input = new_input + "=B"
          break
        when ('knight'.start_with?(promotion.downcase) && promotion.downcase != "k") ||
          promotion.downcase == 'n' then
          self.positions[location][:piece] = 'knight'
          new_input = new_input + "=N"
          break
        else
          promotion = prompt_display("Invalid input, do you promote as queen, rook, bishop, or knight? ")
        end
      end
    end

    status = ""

    enemy_logic = WinOrLose.new(self.positions, enemy, self.history)
    
    if enemy_logic.check?
      enemy_color = (enemy == 1 ? 'white' : 'black')
      enemy_king_key = self.positions.find { |_, v| v[:piece] == 'king' && v[:color] == enemy_color }&.first
      self.positions[enemy_king_key][:active] = true if enemy_king_key
      status = enemy_logic.win? ? "#" : "+"
    elsif enemy_logic.stalemate?
      status = " 1/2-1/2"
    end
    self.input_consolidation.make_move("#{new_input}#{status}")
  end

  def castle(input)
    row = player == 1 ? 7 : 0
    color = player == 1 ? 'white' : 'black'
    rook_old = [row, input == 6 ? 7 : 0]
    rook_new = [row, input == 6 ? 5 : 3]
    text = input == 6 ? "O-O" : "O-O-O"

    king = self.positions.select { |_, v| v[:piece] == 'king' && v[:color] == color }.map { |k, v| [v[:color], k] }
    return false if king.nil?

    current_positions = self.positions.dup
    castle_validity = King.new(king[0][0], king[0][1], current_positions).castle_valid?([row, input])
    
    return false if !castle_validity

    self.positions.each { |_, v| v[:active] = false }
    self.positions.delete_if { |k, v| v[:piece].nil? }

    self.positions[[row, input]] = self.positions.delete(king[0][1])
    self.positions[[row, input]][:active] = true
    self.positions[[row, input]][:moves] += 1
    self.positions[king[0][1]] = { active: true }
    
    self.positions[rook_new] = self.positions.delete(rook_old)
    self.positions[rook_new][:active] = true
    self.positions[[row, input]][:moves] += 1
    self.positions[rook_old] = { active: true }

    self.input_consolidation.make_move("#{text}")
  end

  def display_board
    UpdateBoard.new(self.positions).add_input(self.input_consolidation.moves)
  end

  def display_result
    system('clear') || system('cls')
    puts display_board
    logic = WinOrLose.new(self.positions, self.player, self.history)
    if logic.win?
      puts CenterText.new("CHECKMATE! #{self.player == 1 ? "\e[1;40;37m BLACK \e[0m" : "\e[1;47;30m WHITE \e[0m"} WINS!")
    elsif self.history.threefold?
      puts CenterText.new("DRAW BY THREEFOLD REPETITION!")
    elsif self.history.fifty_moves?
      puts CenterText.new("DRAW BY 50 MOVE RULE!")
    elsif logic.stalemate?
      puts CenterText.new("DRAW! Insufficient material or no legal moves.")
    end
  end

  def prompt_display(prompt)
    system('clear') || system('cls')
    puts display_board
    puts
    print prompt
    gets.chomp
  end

  def press_any_key
    puts
    print CenterText.new("Press any key to return home. ")
    STDIN.getch
    puts
  end

  def self.game
    new.game
  end
end