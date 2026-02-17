require 'io/console'
require_relative 'gameplay'
require_relative 'center-text'

class Menu
  attr_accessor :input
  
  def home
    loop do
      home_display
      self.input = gets.chomp.downcase
      
      if 'start'.start_with?(input) && !input.empty?
        Gameplay.game
      elsif 'tutorial'.start_with?(input) && !input.empty?
        tutorial
        returnHome
      elsif 'quit'.start_with?(input) && !input.empty?
        end_game
        exit
      else
        next
      end
    end
  end

  def returnHome
    puts
    print CenterText.new("Press any key to return to home.")
    STDIN.getch
  end

  def home_display
    system("clear") || system("cls")
    puts CenterText.new(nil,"-")
    puts CenterText.new(nil,"-")
    # Using your epic new title!
    title = "\e[47;1m CHESS: \e[0m\e[47;91;1mEXECUTE THE MATE! \e[0m"
    puts CenterText.new(title,"-")
    puts CenterText.new(nil,"-")
    puts CenterText.new(nil,"-")
    puts
    puts
    puts "Type \e[44;1m  START   \e[0m to \e[1mplay\e[0m."
    puts "Type \e[43;1m TUTORIAL \e[0m to \e[1mknow the mechanics\e[0m"
    puts "Type \e[41;1m   QUIT   \e[0m to \e[1mexit the game\e[0m"
    puts
    puts
    print "---> "
  end

  def tutorial
    system("clear") || system("cls")
    puts CenterText.new(nil,"-")
    puts CenterText.new(nil,"-")
    title = "\e[47;34;1m TUTORIAL \e[0m"
    puts CenterText.new(title,"-")
    puts CenterText.new(nil,"-")
    puts CenterText.new(nil,"-")
    puts
    print "\e[1;106m GOAL: \e[0m"
    print ' Trap the enemy King in "Checkmate" where it cannot escape capture!'
    puts
    puts
    puts "\e[1;43m SYSTEM COMMANDS \e[0m"
    puts " During your turn, you can type these commands:"
    puts " -> \e[1mHELP / TUTORIAL:\e[0m Opens this screen to review rules."
    puts " -> \e[1mMOVES:\e[0m Displays the full history of moves made in the match."
    puts " -> \e[1mQUIT:\e[0m Forfeit the current match and return to the Main Menu."
    puts
    puts "\e[1;45m HOW TO MOVE \e[0m"
    puts ' I.   Input moves using Algebraic Notation (e.g., "e4", "Nf3").'
    puts ' II.  Special Moves: '
    puts "     -> \e[1mCASTLING:\e[0m Type \e[1mo-o\e[0m (King-side) or \e[1mo-o-o\e[0m (Queen-side)."
    puts "     -> \e[1mEN PASSANT:\e[0m A sneaky pawn capture (must be immediate!)."
    puts "     -> \e[1mPROMOTION:\e[0m Reach the end to transform your pawn into a Queen, Rook, Bishop, or Knight!"
    puts
    puts "\e[1;102m  WIN: \e[0m Checkmate → \e[1mThe King falls, you win!\e[0m 👑"
    puts "\e[1;41m LOSE: \e[0m Your King is trapped → \e[1mGame Over.\e[0m 💀"
    puts "\e[1;40;37m DRAW: \e[0m The game is a Tie if any of these occur: "
    puts "     -> \e[1mSTALEMATE:\e[0m You have no legal moves but aren't in check."
    puts "     -> \e[1mLACK OF MATERIAL:\e[0m Not enough pieces left to mate."
    puts "     -> \e[1mOTHERS:\e[0m 50-move rule or Threefold Repetition."
    puts
    puts "\e[1;47m TLDR? \e[0m"
    puts " Move pieces, checkmate the other player. Type \e[1mhelp\e[0m to see this."
    puts " Type \e[1mmoves\e[0m to see all moves made. Type \e[1mquit\e[0m to go home."
    puts
    puts CenterText.new("\e[1mCHECKMATE OR BUST!\e[0m")
    puts
    puts CenterText.new(nil,"-")
  end

  def end_game
    system("clear") || system("cls")
    puts CenterText.new(nil,"-")
    puts CenterText.new(nil,"-")
    title = "\e[47;34;1m THANK YOU FOR PLAYING <3 \e[0m"
    puts CenterText.new(title,"-")
    puts CenterText.new(nil,"-")
    puts CenterText.new(nil,"-")
  end

  def self.home
    new().home
  end
end