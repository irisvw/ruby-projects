# For every square there is a number of possible moves, 
# choose a data structure that will allow you to work with them. 
# Don’t allow any moves to go off the board.

# We're gonna want to use a graph. Every square on the board is a node.
# Every possible move is an edge between two squares on the board. 

# How do we make this graph?
# it would be an unweighted, undirected, cyclic graph. 8*8.
# each node holds its coordinates [0,0] to [7,7]
# each node also holds its neighbors. 

# How do we find the shortest path?
# https://www.geeksforgeeks.org/shortest-path-unweighted-graph/
# steal an existing algorithm!

# What's the shortest path between two nodes in this undirected, unweighted graph? 
# Run BFS from one node and backtrack once you reach the second. 
# Note: BFS always finds the shortest path, assuming the graph is undirected and unweighted. 
# DFS does not always find the shortest path.

# Moves!
# For each node;
# Generate neighbors.
# Disregard neighbors if either their x or y coordinate is not between 0 and 7.
# The possible moves are:
# [x-2, y+1]
# [x-2, y-1]
# [x-1, y+2]
# [x-1, y-2]
# [x+1, y+2]
# [x+1, y-2]
# [x+2, y+1]
# [x+2, y-1]

class Node
  attr_accessor :x, :y, :neighbors
  def initialize(x, y)
    @x = x
    @y = y
    @neighbors = []
    @parent = nil
  end

  # def neighbors(x = @x, y = @y)
  #   moves = [[x-2, y+1], [x-2, y-1], [x-1, y+2], [x-1, y-2], [x+1, y+2], [x+1, y-2], [x+2, y+1], [x+2, y-1]]
  #   moves.keep_if { |move| move[0].between?(0, 7) && move[1].between?(0,7)}
  #   # for each array in this array,
  #   # substitute x and y for @x and @y, and add the result to array neighbors.

  #   # remove all values from array that are not between 0 and 7.
  #   # check each array in array.
  #   # remove if either array[0] or array[1] are not in range 0..7

  #   # actually translate the neighbors to fellow nodes.

  #   # [0,0] -> [[1, 2], [2, 1]]
  #   moves.map { |move| nodes.select { |node| node.x == move[0] && node.y == move[1]}}
  # end
end

class Graph
  attr_accessor :nodes

  def initialize()
    @nodes = generate_nodes
  end

  def generate_nodes
    array = []
    8.times do |x| 
      8.times do |y|
        array << Node.new(x, y)
      end
    end
    @nodes = array
    generate_neighbors(array)
  end

  def generate_neighbors(array)
    array.each do |node|
    x = node.x
    y = node.y
    moves = [[x-2, y+1], [x-2, y-1], [x-1, y+2], [x-1, y-2], [x+1, y+2], [x+1, y-2], [x+2, y+1], [x+2, y-1]]
    moves.keep_if { |move| move[0].between?(0, 7) && move[1].between?(0,7)}
    node.neighbors = moves.map { |move| @nodes.select { |element| element.x == move[0] && element.y == move[1]}}
    end
  end

  def knight_moves(start, finish)
    # shows the shortest possible way to get from one square to another 
    # by outputting all squares the knight will stop on along the way.
  end

  def bfs(root, goal)
    root_node = @nodes.select { |element| element.x == root[0] && element.y == root[1]}
    goal_node = @nodes.select { |element| element.x == goal[0] && element.y == goal[1]}
    queue = [root_node]

    while queue.any?
      # output << [queue[0].x, queue[0].y] # store x and y of root
      # store x and y of every neighbor
      parent = queue[0]
      neighbors = parent.neighbors
      # neighbors.each { |neighbor| queue << neighbor if neighbor.parent.nil?}
      queue.shift
      queue.each { |neighbor| neighbor.parent = parent }
      # queue << queue[0].left unless queue[0].left.nil?
      # queue << queue[0].right unless queue[0].right.nil?
      # queue.shift
      return true if queue.include?(goal_node)
    end
    return false
    # return output unless output.empty?
    # enqueue root.
    # queue all its neighbors (with root as parent?). check if any neighbors are the goal node.
    # true? return root coords, goal coords.
    # false? queue all the neighbor's neighbors (with the previous neighbor as the parent?). check if any neighbors are the goal node.
  end
end

board = Graph.new()
p board.bfs([0,0], [3,3])
