class PlayerInput
  attr_accessor :input, :column, :result

  def initialize(input = nil, column = nil)
    @input = input
    @column = column
    @result = Array.new(6) {Array.new(7, 0)}    
  end

  def place(input = self.input, column = self.column)
    if !column.nil?
      return "FULL" if self.result[0][column - 1] != 0
    end

    if input.nil?
      self.result = Array.new(6) {Array.new(7, 0)}
    else
      place_recursion(input, column)
    end
    result
  end

  def place_recursion(input, column)
    return result if input.nil?
    target_col = column - 1
    result.reverse_each do |row|
      if row[target_col] == 0
        row[target_col] = input
        break
      end
    end
    result
  end
end