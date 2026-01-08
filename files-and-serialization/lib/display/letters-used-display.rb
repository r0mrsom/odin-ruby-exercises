class LettersUsed

  LETTERS = ('A'..'Z').to_a

  def initialize(charUsed)
    @charUsed = charUsed
  end

  def format
    display = LETTERS.reduce(Hash.new()) do |acc, item|
      if @charUsed.include?(item.downcase)
        acc[item] = "\e[47;1m #{item} \e[0m"
      else
        acc[item] = " #{item} "
      end
      acc
    end

    display.values.join(" ")
  end

  def self.alphabet(charUsed)
    puts 
    puts "\e[1;46m#{"LETTERS USED".center(103)}\e[0m"
    puts
    puts new(charUsed).format
  end

  def inputs
    @charUsed.map { |e| e.upcase}.join(", ").center(103)
  end

  def self.inputs(charUsed)
    puts
    puts "\e[1;46m#{"YOUR INPUTS".center(103)}\e[0m"
    puts
    puts new(charUsed).inputs
  end
end

#LettersUsed.alphabet(["a", "b", "e"])
#LettersUsed.inputs(["a", "b", "e"])

