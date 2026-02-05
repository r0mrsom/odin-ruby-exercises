require 'io/console'

class CenterText
  attr_accessor :text, :fill_char
  
  def initialize(text, fill_char = " ")
    @text = text
    @fill_char = fill_char
  end

  def to_s
    terminal_width = IO.console&.winsize&.at(1) || 80

    # If the text is empty, just return one full line of the fill_char
    if @text == nil
      return @fill_char * terminal_width
    end

    @text.each_line.map do |line|
      clean_line = line.chomp
      
      # Get visual length (ignoring ANSI colors)
      actual_visible_width = clean_line.gsub(/\x1b\[[0-9;]*[mK]/, '').length
      
      total_padding = [(terminal_width - actual_visible_width), 0].max
      left_padding_size = total_padding / 2
      right_padding_size = total_padding - left_padding_size
      
      if @fill_char == " "
        (" " * left_padding_size) + clean_line
      else
        (@fill_char * left_padding_size) + clean_line + (@fill_char * right_padding_size)
      end
    end.join("\n")
  end
end

# puts CenterText.new("apple")
# puts CenterText.new(" CONNECT FOUR ", "-")
# puts CenterText.new(nil,"-")