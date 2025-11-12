class ColorDisplay
  COLOR = ["red", "yellow", "green", "blue", "white", "black"].freeze
  COLOR_TEXT = { "red" => "   red   ", "yellow" => " yellow  ", "green" => "  green  ","blue" => "  blue   ", "black" => "  black  ", "white" => "  white  ", false => " ----  "}.freeze
  COLOR_CODES = {"red" => 41, "yellow" => 43, "green" => 42, "blue" => 44, "black" => 40, "white" => 47, false => 49}.freeze

  def initialize(array)
    @array = array
  end

  def display
    @array.map { |c| "\e[#{COLOR_CODES[c]}m#{COLOR_TEXT[c]}\e[0m"}.join(" ")
  end

  def self.display(array)
    new(array).display
  end
end
