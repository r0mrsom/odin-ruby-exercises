require_relative 'human-vs-computer'
require_relative 'computer-vs-human'

class Mastermind

  attr_accessor :human, :computer

  def initialize()
    @human = 0
    @computer = 0
    @mode = ''
  end

  def startGame
    print "\e[H\e[2J"
    puts
    puts "----------------------------------------------------------------------------"
    puts "-----------------------------MASTERMIND-------------------------------------"
    puts "----------------------------------------------------------------------------"
    puts
    puts
    puts "-----------------------------SCORECARD--------------------------------------"
    puts "-------------[HUMAN: #{@human.to_s.rjust(2, '0')}]---------------------[COMPUTER: #{@computer.to_s.rjust(2, '0')}]-----------------"
    puts "----------------------------------------------------------------------------"
    puts
    puts
    print "Play as 'CODEMAKER' or 'CODEBREAKER':   "
    gameMode = gets.chomp
    puts
    
    until gameMode.upcase == "CODEMAKER" || gameMode.upcase == "CODEBREAKER"
      print "Please input again! Play as 'CODEMAKER' or 'CODEBREAKER':   "
      gameMode = gets.chomp
    end

    puts

    if gameMode.upcase == "CODEMAKER"
      @mode = 'computer'
    else
      @mode = 'human'
    end

    gameplay

  end

  def gameplay
    result =
      if @mode == 'computer'
        print "\e[H\e[2J"
        puts
        puts "----------------------------------------------------------------------------"
        puts "------------------------YOU ARE THE CODEMAKER-------------------------------"
        puts "----------------------------------------------------------------------------"
        ComputerToGuess.play(@human, @computer)
      elsif @mode == 'human'
        print "\e[H\e[2J"
        puts
        puts "----------------------------------------------------------------------------"
        puts "-----------------------YOU ARE THE CODEBREAKER------------------------------"
        puts "----------------------------------------------------------------------------"
        HumanToGuess.play(@human, @computer)
      end

    case result
      when :human
        @human += 1
      when :computer
        @computer += 1
    end

    restart
  end

  def restart
    puts
    puts "HUMAN SCORE: #{@human} | COMPUTER SCORE: #{@computer}"
    puts
    puts "Want to play again? (Y/N)"
    userResponse = gets.chomp
    
    until userResponse.upcase == "Y" || userResponse.upcase == "N"
      puts "Invalid input, want to play again? (Y/N)"
      userResponse = gets.chomp
    end

    if userResponse.upcase == "Y"
      startGame
    else
      print "\e[H\e[2J"
      puts
      puts "----------------------------------------------------------------------------"
      puts "------------------------THANK YOU FOR PLAYING!------------------------------"
      puts "----------------------------------------------------------------------------"
    end

  end

  def self.play
    new().startGame
  end

end