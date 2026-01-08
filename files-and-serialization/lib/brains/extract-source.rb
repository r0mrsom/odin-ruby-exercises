require 'yaml'

class DataSource
  PATH = File.expand_path('../../source/google-10000-english-no-swears.txt',__dir__)

  attr_accessor :data
  
  def initialize
    @data ||= YAML.load_file(PATH)
  end

  def data
    @data.split(" ")
  end

  def self.data
    new().data
  end

end