require_relative 'node.rb'
require_relative 'tree.rb'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# array = [1, 7, 4, 23, 8]
# array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
my_tree = Tree.new(array)
my_tree.build_tree

p my_tree.pretty_print