require 'io/console'
require_relative 'game'

class Menu

  attr_accessor :input
  
  def home
    puts "\e[H\e[2J"
    puts '-----------------------------------------------------------------------------------------------------------'
    puts '-----------------------------------------------------------------------------------------------------------'
    puts "----------------------------------------\e[47;1m HANGMAN: \e[0m\e[47;91;1mSAVE THE STICKMAN! \e[0m--------------------------------------"
    puts '-----------------------------------------------------------------------------------------------------------'
    puts '-----------------------------------------------------------------------------------------------------------'
    puts
    puts
    puts "Type \e[44;1m  START   \e[0m to \e[1mplay\e[0m."
    puts "Type \e[43;1m TUTORIAL \e[0m to \e[1mknow the mechanics\e[0m"
    puts "Type \e[41;1m   QUIT   \e[0m to \e[1mexit the game\e[0m"
    puts
    puts
    print "---> "
    self.input = gets.chomp

    check

  end

  def returnHome
    puts
    puts "Press any key to return to home."
    STDIN.getch
    puts "\e[H\e[2J"

    home
  end

  def check
    if input.downcase == 'start'
      Gameplay.new.start
      returnHome
    elsif input.downcase == 'tutorial'
      tutorial
      returnHome
    elsif input.downcase == 'quit'
      endGame
    else
      home
    end
  end

  def tutorial
    puts "\e[H\e[2J"
    puts '-----------------------------------------------------------------------------------------------------------'
    puts '-----------------------------------------------------------------------------------------------------------'
    puts "------------------------------------------------\e[47;34;1m TUTORIAL \e[0m-------------------------------------------------"
    puts '-----------------------------------------------------------------------------------------------------------'
    puts '-----------------------------------------------------------------------------------------------------------'
    puts
    print "\e[1;106m GOAL: \e[0m"
    print ' Guess the secret word before our stickman meets his doom!'
    puts
    puts
    puts "\e[1;43m HOW TO SAVE HIM \e[0m"
    puts ' I.   Guess one letter at a time.'
    puts '     -> Correct? The letter appears and stickman cheers. 🎉'
    puts '     -> Each wrong letter adds a body part to our unfortunate stickman: head, body, arms, legs…'
    puts " II.  Keep track of letters—you don’t want to doom him by mistake!"
    puts
    puts "\e[1;102m  WIN:  \e[0m Reveal the whole word → \e[1mstickman lives!\e[0m"
    puts "\e[1;41m LOOSE: \e[0m Too many wrong guesses → \e[1mstickman’s… gone.\e[0m 😱"
    puts
    puts
    puts "\e[1;47m TLDR? \e[0m"
    puts " Guess letters. Don’t kill the stickman. Fail and he’s stick soup. Good luck."
    puts
    puts '-----------------------------------------------------------------------------------------------------------'
    
  end

  def endGame
     puts "\e[H\e[2J"
    puts '-----------------------------------------------------------------------------------------------------------'
    puts '-----------------------------------------------------------------------------------------------------------'
    puts "---------------------------------------\e[47;34;1m THANK YOU FOR PLAYING <3 \e[0m------------------------------------------"
    puts '-----------------------------------------------------------------------------------------------------------'
    puts '-----------------------------------------------------------------------------------------------------------'
  end

  def self.home
    new().home
  end

end
