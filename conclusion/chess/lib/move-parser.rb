class MoveParser
  attr_accessor :output
  attr_reader :input
  
  def convert(input)
    return if !matches_pattern?(input)
    input_length = input.length
    if input_length == 2
      [nil, [8 - input[1].to_i, input[0].downcase.ord - 97]]
    elsif input_length == 3
      [nil, [8 - input[2].to_i, input[1].downcase.ord - 97]]
    elsif input_length == 4
      if input[1].to_i.between?(1, 8)
        [[8 - input[1].to_i, input[0].downcase.ord - 97], [8 - input[3].to_i, input[2].downcase.ord - 97]]
      else
        [input[1].downcase.ord - 97, [8 - input[3].to_i, input[2].downcase.ord - 97]]
      end
    elsif input_length == 5
      [[8 - input[2].to_i, input[1].downcase.ord - 97], [8 - input[4].to_i, input[3].downcase.ord - 97]]
    end
  end

  def piece_identifier(input)
    return if !matches_pattern?(input)
    pieces = {'k' => 'king', 'q' => 'queen', 'b' => 'bishop', 'r' => 'rook', 'n' => 'knight', 'p' => 'pawn' }
    if input.length == 2
      'pawn'
    elsif input.length == 3
      pieces[input[0].downcase]
    elsif input.length == 4
      if input[1].downcase.between?('a','h')
        pieces[input[0].downcase]
      else
        'pawn'
      end
    elsif input.length == 5
      pieces[input[0].downcase]
    end

  end

  def matches_pattern?(input)
    input_length = input.length
    if input_length == 2
      input[0].downcase.between?('a','h') &&
      input[1].to_i.between?(1, 8)

    elsif input_length == 3
      ['k', 'q', 'b', 'r', 'n', 'p'].include?(input[0].downcase) &&
        input[1].downcase.between?('a', 'h') &&
        input[2].to_i.between?(1, 8)

    elsif input_length == 4
      test_1 = ['k', 'q', 'b', 'r', 'n', 'p'].include?(input[0].downcase) &&
        input[1].downcase.between?('a', 'h') &&
        input[2].downcase.between?('a', 'h') &&
        input[3].to_i.between?(1, 8)
      test_2 = input[0].downcase.between?('a', 'h') &&
        input[1].to_i.between?(1, 8) &&
        input[2].downcase.between?('a', 'h') &&
        input[3].to_i.between?(1, 8)
      test_1 || test_2

    elsif input_length == 5
      ['k', 'q', 'b', 'r', 'n', 'p'].include?(input[0].downcase) && 
        input[1].downcase.between?('a', 'h') &&
        input[2].to_i.between?(1, 8) &&
        input[3].downcase.between?('a', 'h') &&
        input[4].to_i.between?(1, 8)
    end
  end

  def self.convert(input)
    new.convert(input)
  end

  def self.piece_identifer(input)
    new.piece_identifier(input)
  end

  def self.matches_pattern?(input)
    new.matches_pattern?(input)
  end
end

# test = MoveParser.new
# puts test.piece_identifier("Pa4")
# puts test.piece_identifier("Ngf8")