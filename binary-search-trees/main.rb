require_relative 'node.rb'
require_relative 'tree.rb'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# array = [1, 7, 4, 23, 8]
# array = [1, 2, 3, 4, 5]
# array = [1, 2]
my_tree = Tree.new(array)
my_tree.build_tree

my_tree.pretty_print

# my_tree.insert(2)
# my_tree.insert(7)
# my_tree.pretty_print

my_tree.delete(6345)
my_tree.delete(5)
my_tree.pretty_print

my_tree.delete(8)
my_tree.pretty_print

p my_tree.find(7)
p my_tree.find(67)

puts "Test: level_order"
p my_tree.level_order
p my_tree.level_order {|element| p element * 2}
puts ""

puts "Test: preorder. Expect: [9, 4, 1, 3, 7, 67, 23, 324]"
p my_tree.preorder
puts ""

puts "Test: inorder. Expect: [1, 3, 4, 7, 9, 23, 67, 324]"
p my_tree.inorder
puts ""

puts "Test: postorder. Expect: [3, 1, 7, 4, 23, 324, 67, 9]"
p my_tree.postorder
puts ""