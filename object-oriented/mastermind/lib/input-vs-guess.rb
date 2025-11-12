class InputVSGuess
  def initialize(input, guess)
    @input = input # Initialize the instance variable
    @guess = guess
  end

  class HashConvert
    def initialize(arrayInput)
      @arrayInput = arrayInput
    end

    def self.convert(arrayInput)
      result = Hash.new()
      arrayInput.map.with_index { |element, i| result[i] = element }
      result
    end
  end

  def inputHash
    HashConvert.convert(@input)
  end

  def guessHash
    HashConvert.convert(@guess)
  end

  def exactCompare
    inputHash.map { |i, element| element == guessHash[i] }
  end

  def compare
    inputColorCount = @input.reduce(Hash.new(0)) do |acc, item| 
      acc[item] += 1
      acc
    end

    #guessColorCount = @guess.reduce(Hash.new(0)) do |acc, item|
    #  acc[item] += 1
    #  acc
    #end

    @guess.map do |color|
      if inputColorCount[color] > 0
        inputColorCount[color] -=1
        true
      else
        false
      end
    end

  end

  def result
    compare.map.with_index do |item, i|
      if item == true && exactCompare[i] == true
        "black"
      elsif item == true
        "white"
      else
        false
      end
    end
  end

  def self.result(input, guess)
    new(input, guess).result.shuffle
  end

end