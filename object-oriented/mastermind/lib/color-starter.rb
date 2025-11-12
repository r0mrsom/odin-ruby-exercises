class ColorGenerator
  COLOR = ["red", "yellow", "green", "blue"].freeze

  def initialize
    @guess = []
    for i in (0..3) do
      @guess[i] = COLOR[rand(4).floor]
    end
  end

  def array
    @guess
  end

  def self.create
    new().array
  end

end