def fibs(number)
  return [0] if number == 1
  result = [0, 1]
  for iteration in (2...number)
    result[iteration] = result[iteration - 1] + result[iteration - 2]
  end
  result
end

def fibs_rec(number, iteration = 2, result = [0, 1])
  return [0] if number == 1
  return result if iteration >= number
  result[iteration] = result[iteration - 1] + result[iteration - 2]
  fibs_rec(number, iteration + 1, result)
end