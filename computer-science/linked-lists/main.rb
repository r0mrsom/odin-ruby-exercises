require_relative "linked-list"

#CODE TESTING HERE

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

list.prepend("alien")

puts list.to_s
puts list.size
puts list.head
puts list.tail
puts list.at(4)

puts list.pop
puts list.to_s

puts list.contains?("dog")
puts list.contains?("cat")
puts list.contains?("mushroom")

p list.index("turtle")
p list.index("mushroom")

list.insert_at(0, "mice", "elephant")
puts list.to_s
list.insert_at(2, "kangaroo", "zebra")
puts list.to_s
list.insert_at(10, "giraffe", "lion")
puts list.to_s

#This will give IndexError
#list.insert_at(13, 1, 5)

new_list = LinkedList.new
#This will give IndexError as well
#new_list.insert_at(1, "giraffe")
new_list.insert_at(0, "giraffe", "elephant")
puts new_list.to_s

new_list.remove_at(1)
puts new_list.to_s
#These will give IndexError
#new_list.remove_at(10)
#LinkedList.new.remove_at(0)

