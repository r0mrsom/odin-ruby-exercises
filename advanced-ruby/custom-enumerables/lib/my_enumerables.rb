module Enumerable
  
  def my_each_with_index
    return self unless block_given?
    i = 0
    
    for element in self
      yield(element, i)
      i += 1
    end

    self
  end
  
  def my_select
    return self unless block_given?
    result = []

    for element in self
      if yield(element)
        result << element
      end
    end

    result
  end

  def my_all?
    result = true

    for element in self
      if !yield(element)
        result = false
        break
      end
    end

    result
  end

  def my_any?
    result = false

    for element in self
      if yield(element)
        result = true
        break
      end
    end

    result
  end

  def my_none?
    result = true

    for element in self
      if yield(element)
        result = false
        break
      end
    end

    result
  end

  def my_count(&block)
    if block == nil
      self.length
    else
      result = 0
      
      for element in self
        if block.call(element)
          result += 1
        end
      end

      result
    end
  end

  def my_map
    result = []

    for element in self
      result << yield(element)
    end

    result

  end

  def my_inject(accumulator = 0)

    for element in self
      accumulator = yield(accumulator, element)
    end
    
    accumulator
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return self unless block_given?
    
    for element in self
      yield element
    end

    self
  end
end
