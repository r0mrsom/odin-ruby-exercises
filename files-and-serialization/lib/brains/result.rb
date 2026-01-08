require_relative 'character-input'

class Result
  LETTERS = ('A'..'Z').to_a

  attr_reader :word, :charUsed

  def initialize(word, charUsed)
    @word = word
    @charUsed = charUsed
  end

  def checker
    @word.map do |charToGuess|
      @charUsed.include?(charToGuess)
    end
  end

  def blank_to_fill
    checker.each_with_index.map do |element, index|
      element ? word[index].upcase : "_"
    end
  end

  def self.checker(word, charUsed)
    new(word, charUsed).checker
  end

end

#word = "apple".split("")
#charUsed = []
#testing = Result.new(word, charUsed)
#p testing.checker
#p testing.blank_to_fill