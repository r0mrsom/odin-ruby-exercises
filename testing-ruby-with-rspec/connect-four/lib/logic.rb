class Logic
  RANGES =  [[[0, 0], [1, 0], [2, 0], [3, 0]],
             [[0, 0], [0, 1], [0, 2], [0, 3]],
             [[0, 0], [-1, 1], [-2, 2], [-3, 3]],
             [[0, 0], [-1, -1], [-2, -2], [-3, -3]]]

  attr_accessor :result, :input, :column 

  def check_win(result)
    result.each_with_index do |rows, r|
      rows.each_with_index do |columns, c|
        if per_input_check(columns, r, c, result)
          return columns == 1 ? "RED" : "BLUE"
        end  
      end
    end
    nil
  end

  def check_tie(result)
    return true if is_empty?(result) && check_win(result).nil?
    false
  end

  def self.check_win(result)
    new.check_win(result)
  end

  def self.check_tie(result)
    new.check_tie(result)
  end

  private

  def is_empty?(result)
    result.flatten.none? { |elements| elements == 0 }
  end

  def per_input_check(input, row, column, result)
    RANGES.map { |combinations|
      combinations.map { |pairs| pair_checker(pairs, input, row, column, result) }.all?(true)
    }.any?(true)
  end

  def pair_checker(pair, input, row, column, result)
    return nil if !(row + pair[0]).between?(0, 5) || !(column + pair[1]).between?(0, 6)
    if result[row + pair[0]][column + pair[1]] == input && (input == 1 || input == -1)
      true
    else
      false
    end
  end
end