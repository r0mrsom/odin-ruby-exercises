class StickMan
  
  def initialize(wrongGuess)
    @wrongGuess = wrongGuess
    @text = 
    [ "  +----+",
      "  |    |",
      "  O    |",
      " /|\\   |",
      " / \\   |",
      "       |",
      "       |",
      "============"]
  end

  def display
    newStick
    @text.map { |e| e.center(103) }.join("\n")
  end
  
  def self.display(wrongGuess)
    puts
    puts new(wrongGuess).display
  end

  def newStick
    
    if @wrongGuess == 0
      @text[2][2] = " "        #HEAD
      @text[3][1..3] = "   "   #BODY AND ARMS
      @text[4][1..3] = "   "   #LEGS
    elsif @wrongGuess == 1
      @text[2][2] = "O"        #HEAD
      @text[3][1..3] = "   "   #BODY AND ARMS
      @text[4][1..3] = "   "   #LEGS
    elsif @wrongGuess == 2
      @text[2][2] = "O"        #HEAD
      @text[3][1..3] = " | "   #BODY AND ARMS
      @text[4][1..3] = "   "   #LEGS
    elsif @wrongGuess == 3
      @text[2][2] = "O"        #HEAD
      @text[3][1..3] = '/| '   #BODY AND ARMS
      @text[4][1..3] = '   '   #LEGS
    elsif @wrongGuess == 4
      @text[2][2] = "O"        #HEAD
      @text[3][1..3] = '/|\\'   #BODY AND ARMS
      @text[4][1..3] = '   '   #LEGS
    elsif @wrongGuess == 5
      @text[2][2] = "O"        #HEAD
      @text[3][1..3] = "/|\\"   #BODY AND ARMS
      @text[4][1..3] = '/  '   #LEGS
    elsif @wrongGuess == 6
      @text[2][2] = "          \e[31;1mO\e[0m"         #HEAD
      @text[3][1..3] = "          \e[31;1m/|\\\e[0m"   #BODY AND ARMS
      @text[4][1..3] = "          \e[31;1m/ \\\e[0m"   #LEGS
    end
  end
end

class StickManSaved
  
  def initialize(win)
    @win = win
    @text = 
    [ "",
      "",
      "",
      "",
      "        \e[92;1m\\O/\e[0m",
      "       \e[92;1m|\e[0m",
      "       \e[92;1m/ \\\e[0m",
      "============"]
  end

  def display
    if @win == true
      @text.map { |e| e.center(103)}.join("\n")
    end
  end

  def self.display(win)
    puts
    puts new(win).display
  end

end
