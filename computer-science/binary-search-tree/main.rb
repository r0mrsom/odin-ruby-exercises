require_relative 'lib/tree'

#TESTING HERE
array = Array.new(15) { rand(1..1000) }
test = Tree.new(array)
test.pretty_print
p test.balanced?
p test.levelorder
p test.preorder
p test.inorder
p test.postorder
test.insert(1001)
test.insert(1002)
test.insert(1003)
test.pretty_print
test.delete(1002)
test.pretty_print
p test.balanced?
test.rebalance
test.pretty_print
p test.balanced?
p test.levelorder
p test.preorder
p test.inorder
p test.postorder