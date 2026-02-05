require_relative 'logic'
require_relative 'player-input'
require_relative 'display'
require_relative 'center-text'

class Gameplay
  COLOR = { 1 => "\e[41;1m RED \e[0m", -1 => "\e[44;1m BLUE \e[0m" }

  attr_accessor :result, :player_manager

  def initialize(player_manager = PlayerInput.new)
    @result = Array.new(6) { Array.new(7, 0) }
    @player_manager = player_manager
    @player_manager.input = 1
    @player_manager.result = @result
  end

  def game
    until game_over?
      play_turn
      switch_player
    end
    conclude_game
  end

  def play_turn
    display
    prompt("#{current_player_name}'s turn!")
    
    loop do
      column = column_input.to_i
      break if verify_and_place(column)
    end
  end

  def verify_and_place(column)
    unless column.between?(1, 7)
      display
      prompt("Invalid input #{current_player_name}, try 1-7.")
      return false
    end

    @player_manager.column = column
    if @player_manager.place == "FULL"
      display
      prompt("Column #{column} is FULL, #{current_player_name}, try again.")
      return false
    end

    true
  end

  private

  def game_over?
    Logic.check_win(@result) || Logic.check_tie(@result)
  end

  def switch_player
    @player_manager.input = (@player_manager.input == 1 ? -1 : 1)
  end

  def current_player_name
    COLOR[@player_manager.input]
  end

  def conclude_game
    display
    prompt("\e[47;1m GAME OVER! \e[0m")
    puts CenterText.new(win_message)
    puts CenterText.new(nil, "=")
  end

  def win_message
    if Logic.check_tie(@result)
      "Nobody won."
    else
      Logic.check_win(@result) == "RED" ? "#{COLOR[1]} WINS" : "#{COLOR[-1]} WINS"
    end
  end

  def display(result = self.result)
    system("clear") || system("cls")
    formatted_grid = Display.print(result)
    puts
    puts CenterText.new(nil,"=")
    puts
    puts CenterText.new(formatted_grid)
  end

  def prompt(message)
    puts
    col_ref = (1..7).map { |num| "\e[49;1m #{num}  \e[0m" }.join("  ")
    puts CenterText.new(col_ref)
    puts
    puts CenterText.new(nil,"=")
    puts CenterText.new(message)
    puts CenterText.new(nil,"=")
  end

  def column_input
    puts
    print CenterText.new("Place token (Choose from columns 1 - 7): ").to_s.chomp
    gets.chomp
  end

  def self.start
    new.game
  end
end