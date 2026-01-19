require_relative 'hashmap'

test = HashMap.new
p "--------------TEST UPDATING OF KEY VALUE-------------------"
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

p test.length
p test.keys
p test.values
p test.entries

p "-----------TEST UPDATING OF KEY VALUE------"
test.set("lion", "goldenish silver")
test.set("kite", "rainbow")
p test.length
p test.keys
p test.values
p test.entries


p "-------TEST REMOVAL OF KEY--------------"
test.remove("lion")
p test.length
p test.keys
p test.values
p test.entries

test.set("lion", "golden")


p "--------TESTING OF GROWTH FUNCTION------------"

p "########## Previous Hashmap: #####################"
test.to_s
test.set('moon', 'silver')
test.set('dance', 'rhythm')
test.set('custom', 'order')
p "########## New Hashmap: ##########################"
test.to_s
p "##################################################"
p test.length
p test.keys
p test.values
p test.entries

p "---------TESTING OF GROWTH FUNCTION AGAIN-----------"

p "########## Previous Hashmap: ##################3"
test.to_s
test.set('ocean', 'deep blue')
test.set('pencil', 'graphite')
test.set('quartz', 'crystal')
test.set('river', 'flow')
test.set('sun', 'yellow')
test.set('tiger', 'orange')
test.set('umbrella', 'purple')
test.set('violin', 'wood')
test.set('whale', 'blue')
test.set('x-ray', 'clear')
p "########## New Hashmap: ########################"
test.to_s
p "################################################"
p test.length
p test.keys
p test.values
p test.entries

p "--------TESTING OF GET, HAS?, LENGTH, KEYS, VALUES, AND ENTRIES------------"
p test.get('x-ray')
p test.get('xray')
p test.has?('sun')
p test.has?('son')
p test.length
p test.keys
p test.values
p test.entries

p "-----------------TEST OF CLEAR--------------------------"
test.clear
p test.length
p test.keys
p test.values
p test.entries