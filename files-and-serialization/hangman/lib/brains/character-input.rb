require_relative 'random-word-getter'

class CharacterInput
  
  def self.new
    print 'Input a letter: '
    character = gets.chomp

    while !((('a'...'z').cover?(character) || ('A'...'Z').cover?(character)) && character.length == 1)
      print 'Input is invalid, input a character: '
      character = gets.chomp
    end

    character.downcase

  end
end