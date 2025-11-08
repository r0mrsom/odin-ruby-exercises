class WinChecker
  def initialize(accumulator)
    @accumulator = accumulator
  end

  def winning?
    winningCombinations = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

    result = winningCombinations.map { |combination| combination.all? { |item| @accumulator.include?(item)}}

    result.any?(true)
  end
end

class XorO
  def initialize(accumulator)
    @accumulator = accumulator
  end

  def promptInput
    oddInput = @accumulator.select.with_index { |item, iteration| item if iteration % 2 == 0 }

    evenInput = @accumulator.select.with_index { |item, iteration| item if iteration % 2 == 1 }

    odd = WinChecker.new(oddInput)
    even = WinChecker.new(evenInput)

    [odd.winning?, even.winning?]
  end

  def self.promptInput(accumulator)
    new(accumulator).promptInput
  end
end