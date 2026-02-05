require 'io/console'
require_relative 'game'
require_relative 'center-text'
require_relative 'game'

class Menu
  attr_accessor :input
  
  def home
    loop do
      home_display
      self.input = gets.chomp
      if 'start'.start_with?(input.downcase) && !input.empty?
        Gameplay.start
        returnHome
      elsif 'tutorial'.start_with?(input.downcase) && !input.empty?
        tutorial
        returnHome
      elsif 'quit'.start_with?(input.downcase) && !input.empty?
        endGame
        break
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
    title = "\e[47;1m CONNECT FOUR: \e[0m\e[47;91;1mCOMPLETE THE QUAD! \e[0m"
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
    print ' Align four of your colored discs in a row before your opponent does!'
    puts
    puts
    puts "\e[1;43m HOW TO WIN THE GAME \e[0m"
    puts ' I.   Choose your color: Red or Blue.'
    puts '     -> Players take turns selecting a column (1-7).'
    puts '     -> Your disc falls to the lowest empty space in that column.'
    puts " II.  Connect 4 discs in any direction: "
    puts '     -> Horizontal! (Left to right).'
    puts '     -> Vertical! (Top to bottom)'
    puts '     -> Diagonal (The "Sneaky Sis" special).'
    puts " III. Block your rival! "
    puts "     -> Don't let them get three in a row, or you're toast."
    puts
    puts "\e[1;102m  WIN: \e[0m 4 in a Row → \e[1mvictory is yours!\e[0m 🎉"
    puts "\e[1;41m LOSE: \e[0m Opponent connects 4 → \e[1mBetter luck next time.\e[0m 😱"
    puts "\e[1;40;37m DRAW: \e[0m The 6x7 grid is full with no winner → \e[1mA stalemate.\e[0m 😐"
    puts
    puts
    puts "\e[1;47m TLDR? \e[0m"
    puts " Pick a column. Drop your color. Get four in a row. Don't let the other guy win."
    puts " \e[1mGO 4 IT!\e[0m"
    puts
    puts CenterText.new(nil,"-")
  end

  def endGame
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
