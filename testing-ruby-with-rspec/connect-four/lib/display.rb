class Display
  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def print(input = self.input) 
    result = input.map { |elements| elements.map { |cell| format(cell) }.join("  ") }.join("\n\n")

    result
  end

  def self.print(input)
    new(input).print
  end

  private

  def format(cell)
    case cell
    when 0 then "\e[100m    \e[0m" # Grey
    when -1 then "\e[104m    \e[0m" # Blue
    when 1 then "\e[101m    \e[0m" # Red
    end
  end
end

# input = [[0, 0, 0, 0, 0, 0, 0],
#         [0, 0, 0, 0, 0, 0, 0],
#         [0, 0, 0, 0, 0, 0, 0],
#         [0, 0, 0, 0, 0, 0, 0],
#         [0, 0, 0, 0, 0, 0, 0],
#         [-1, 0, 1, 0, -1, 0, 1]]

# test = Display.new(input)
# puts test.print