class Chess
  MAP = [[-2, 1], [-2, -1], [-1, 2], [-1, -2], [1, 2], [1, -2], [2, 1], [2, -1]]

  attr_accessor :queue, :visited, :home, :current

  def initialize(current, home)
    @current = current
    @home = home
    @queue = [[current]]
    @visited = [current]
  end

  def next_move_finder(current)
    result = []
    MAP.each do |element|
      x_result = current[0] + element[0]
      y_result = current[1] + element[1]
      if x_result.between?(0, 7) && y_result.between?(0, 7) && !visited.include?([x_result, y_result])
        result << [x_result, y_result]
      end
    end
    result
  end

  def path_finder
    until queue.empty?
      path = queue.shift
      current_location = path.last
      return path if current_location == home
      moves = next_move_finder(current_location)

      moves.each do |move|
        visited << move
        new_path = path + [move]
        queue << new_path
      end
    end
  end
end

def knight_moves(start, home)
  result = Chess.new(start, home).path_finder
  puts "You made it in #{result.length} moves! Here's your path:"
  result.each { |move| p move}
end