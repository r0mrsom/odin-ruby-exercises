require_relative 'extract-source'

class WordGetter
  DICTIONARY = DataSource.data

  def self.wordArchive
    DICTIONARY.select { |element| element.length.between?(5, 12) }
  end

end

class WordToGuess
  DICTIONARY = WordGetter.wordArchive

  def self.new
    DICTIONARY[rand(DICTIONARY.length)]
  end

end