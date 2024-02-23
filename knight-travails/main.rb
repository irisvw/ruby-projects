class Node
  attr_accessor :x, :y, :neighbors, :parent
  def initialize(x, y)
    @x = x
    @y = y
    @neighbors = []
    @parent = nil
  end
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
      node.neighbors = moves.map { |move| @nodes.find { |element| element.x == move[0] && element.y == move[1]}}
    end
  end

  def knight_moves(start, finish)
    path = bfs(start, finish) 
    short_path = path.map { |node| "[#{node.x}, #{node.y}]" }.reverse!
    puts "You made it in #{path.length} move(s)! Here's your path:"
    short_path.each { |step| puts step }
    puts ""
  end

  def bfs(root, goal)
    @nodes.each { |node| node.parent = nil}

    root_node = @nodes.find { |element| element.x == root[0] && element.y == root[1]}
    goal_node = @nodes.find { |element| element.x == goal[0] && element.y == goal[1]}
    queue = [root_node]

    while queue.any?
      queue[0].neighbors.each do |neighbor|
        next unless neighbor.parent.nil?
        neighbor.parent = queue[0]
        queue << neighbor
      end
      queue.shift

      if queue.include?(goal_node)
        current = goal_node
        path = [current]
        loop do
          current = current.parent
          path << current
          break if current == root_node
        end
        
        return path
      end
    end
    return false
  end

end

board = Graph.new()
board.knight_moves([0,0], [3,3])
board.knight_moves([0,0], [7,7])
