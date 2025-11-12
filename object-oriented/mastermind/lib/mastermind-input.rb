class MastermindInput
  COLOR = ["red", "yellow", "green", "blue"].freeze

  def initialize()
    puts
    print "Input your guess (choose from red, yellow, green, and blue): "
    @input = gets.chomp
    while !lengthIsFour? || !isInputValid?
      if !lengthIsFour?
        print "You only inputted " + array.length.to_s + " color guesses, please input your guess again: "
      elsif !isInputValid? && lengthIsFour?
        print "Some colors are invalid, please input your guess again: "        
      else
        print "Input invalid, please input your guess again: "
      end
      @input = gets.chomp
    end
  end

  def array
    @input.split(",").map { |element| element.strip }
  end

  def lengthIsFour?
    array.length == 4
  end

  def isInputValid?
    array.all? { |colorInput| COLOR.any? { |item| item == colorInput }}
  end

  def self.create
    new().array
  end

end