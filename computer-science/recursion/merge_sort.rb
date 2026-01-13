def merge_sort(array)
  if array.length == 2
    array[0], array[1] = array.min, array.max
  elsif array.length <= 1
    array
  else
    length = array.length
    a = merge_sort(array[0...(0.5 * length).ceil])
    b = merge_sort(array[(0.5 * length).ceil...length])
    array = merger(a, b, length)
  end
  array
end

def merger(a, b, length, result = [])
  return result if result.length >= length
  if a.length == 0
    result = result + b
    merger(a, b, length, result)
  elsif b.length  == 0
    result = result + a
    merger(a, b, length, result)
  elsif a[0] > b[0]
    result << b.shift
    merger(a, b, length, result)
  else
    result << a.shift
    merger(a, b, length, result)
  end
end

#TESTING
p merge_sort([])
p merge_sort([5])
p merge_sort([1, 2, 3, 4, 5])
p merge_sort([5, 4, 3, 2, 1])
p merge_sort([38, 27, 43, 3, 9, 82, 10])
p merge_sort([4, 1, 3, 4, 2, 1])
p merge_sort([7, 7, 7, 7])
p merge_sort([-3, -1, -7, -4, -5])
p merge_sort([3, -2, -5, 0, 4, -1])
p merge_sort([1_000_000, 500, 10_000, 1])
