require_relative 'node.rb'
require_relative 'tree.rb'

array = (Array.new(15) { rand(1..100) })
binary_tree = Tree.new(array)

puts "2. Confirm that the tree is balanced by calling #balanced?"
p binary_tree.balanced?
puts ""

puts "3. Print out all elements in level, pre, post, and in order"
puts "Level order:"
p binary_tree.level_order
puts ""
puts "Preorder:"
p binary_tree.preorder
puts ""
puts "Postorder:"
p binary_tree.postorder
puts ""
puts "Inorder:"
p binary_tree.inorder
puts ""

puts "4. Unbalance the tree by adding several numbers > 100"
binary_tree.insert(314)
binary_tree.insert(159)
binary_tree.insert(265)
binary_tree.pretty_print
puts ""

puts "5. Confirm that the tree is unbalanced by calling #balanced?"
p binary_tree.balanced?
puts ""

puts "6. Balance the tree by calling #rebalance"
binary_tree.rebalance
binary_tree.pretty_print
puts ""

puts "7. Confirm that the tree is balanced by calling #balanced?"
p binary_tree.balanced?
puts ""

puts "8. Print out all elements in level, pre, post, and in order"
puts "Level order:"
p binary_tree.level_order
puts ""
puts "Preorder:"
p binary_tree.preorder
puts ""
puts "Postorder:"
p binary_tree.postorder
puts ""
puts "Inorder:"
p binary_tree.inorder
puts ""