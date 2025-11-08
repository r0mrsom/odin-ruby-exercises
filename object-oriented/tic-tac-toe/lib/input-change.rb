class ChangeInput
  def initialize(array, accumulator)
    @array = array
    @accumulator = accumulator
  end

  def charImputer
    if @accumulator.length % 2 == 0
      "X"
    else
      "O"
    end
  end

  def inputPlacer
    print charImputer + "'s Turn!"
    puts
    print "Input number to place: "

    number = gets.chomp
    while @accumulator.include?(number.to_i) || number.to_i.between?(1, 9) == false
      puts "Invalid input! Input VALID number to place " + charImputer
      number = gets.chomp
    end

    number.to_i
  end

  def inputChanger
    place = inputPlacer

    @array[place] = charImputer
    @accumulator.push(place)
  end

  def self.inputChanger(array, accumulator)
    new(array, accumulator).inputChanger
  end
end