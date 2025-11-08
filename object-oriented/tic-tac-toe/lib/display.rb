class ScreenPrint
  def initialize(array)
    @array = array
  end

  def input_extractor
    top_row    = @array.select { |key, _| key <= 3 }
    middle_row = @array.select { |key, _| key.between?(4, 6) }
    bottom_row = @array.select { |key, _| key.between?(7, 9) }
    [top_row, middle_row, bottom_row]
  end

  def print_screen
    rows = input_extractor
    puts
    puts "+---+---+---+"
    puts "| " << rows[0].values.join(" | ") << " |"
    puts "+---+---+---+"
    puts "| " << rows[1].values.join(" | ") << " |"
    puts "+---+---+---+"
    puts "| " << rows[2].values.join(" | ") << " |"
    puts "+---+---+---+"
    puts
  end

  def self.printScreen(array)
    new(array).print_screen
  end
end
