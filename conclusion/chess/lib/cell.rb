class Cell
  COLOR = {
    'reset' => "\e[0m",
    'black' => "\e[37;40m",
    'white' => "\e[30;107m",
    'bg_gray' => "\e[100m",
    'bg_white' => "\e[30;47m",
    'bg_red' => "\e[101m"}

  attr_accessor :bg_color, :piece_color, :text

  def initialize(bg_color, piece_color = nil, text = "     ")
    @bg_color = bg_color
    @piece_color = piece_color
    @text = text
  end

  def colorize(color, text)
    "#{COLOR[color]}#{text}#{COLOR['reset']}"
  end

  def render
    [ colorize(self.bg_color, "       "),
      colorize(self.bg_color, " ") + colorize(self.piece_color, self.text) + colorize(self.bg_color, " "),
      colorize(self.bg_color, "       ")]
  end
end