class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree
  end

  def build_tree(array = @array, start = 0, finish = @array.length - 1)
    # base case
    return nil if start > finish

    # calculate mid point
    mid = (start + finish) / 2

    # set middle element as root
    root = Node.new(array[mid])

    # calculate mid of left_array, assign to left
    root.left = build_tree(array, start, mid-1)

    # calculate mid of right_array, assign to right
    root.right = build_tree(array, mid+1, finish)

    # return root as node
    return root
  end

  def insert(value, root = @root)
    # accepts value to insert
    # always as a leaf
    # search for the parent key from the root

    # base case
    return Node.new(value) if root.nil?

    # return existing value if value already exists
    if root.data == value
      return root
    elsif root.data < value
      root.right = insert(value, root.right)
    else
      root.left = insert(value, root.left)
    end

    return root
    # currentnode.data == value ? return nil.
    # currentnode.data < value ? currentnode = currentnode.right
    # currentnode.data > value ? currentnode = currentnode.left
    # if node.left.nil? && node.right.nil?
    # if value > currentnode.data, currentnode.right = value
    # else currentnode.left = value
  end

  def delete(value, root = @root)
    # accepts value to delete
    # recursively traverse the tree?

    # base case
    return root if root.nil?

    if root.data < value
      root.right = delete(value, root.right)
      return root
    elsif root.data > value
      root.left = delete(value, root.left)
      return root
    end

    # case 2: node with 1 kid
    # replace node with its child

    if root.left.nil?
      root = root.right 
      return root
    elsif root.right.nil?
      root = root.left
      return root
    else
      # case 3: node with 2 kids
      # find the smallest value in its right subtree
      
      parent_root = root
      next_root = root.right

      # next_root = next_root.left until next_root.left.nil?
      while next_root.left != nil
        parent_root = next_root
        next_root = next_root.left
      end

      # if next_root has no kids, replace root with next_root and get rid of next_root.
      # if next_root has a kid, it's always a kid with a larger value than itself.
      # append kid to next_root's parent on the left side. 
      root.data = next_root.data

      if parent_root != root
        parent_root.left = next_root.right
      else
        parent_root.right = next_root.right 
      end

      return root
    end
  end

  def find(value, root = @root)
    # returns the node with the given value

    # start at root
    # is given value equal to root? return root.
    # is given value greater than root? find(root.right)
    # else? find(root.left)
    return nil if root.nil?
    # base case
    if root.data == value
      return root
    elsif root.data < value
      root = find(value, root.right)
    else
      root = find(value, root.left)
    end
    return root
  end

  def level_order(root = @root)
    # breadth first
    # visit root. store left and right in queue. execute block for root.
    # visit nodes in queue in order. execute block, queue children, remove node.
    return if root.nil?

    queue = [root]
    output = []

    while queue.any?
      if block_given?
        yield(queue[0].data)
      else
        output << queue[0].data
      end
      queue << queue[0].left unless queue[0].left.nil?
      queue << queue[0].right unless queue[0].right.nil?
      queue.shift
    end

    return output unless output.empty?
  end

  def inorder(root = @root, output = [])
    return if root.nil?

    inorder(root.left, output)
    if block_given?
      yield(root.data)
    else
      output << root.data
    end
    inorder(root.right, output)
    return output
  end

  def preorder(root = @root, output = [])
    return if root.nil?

    if block_given?
      yield(root.data)
    else
      output << root.data
    end
    preorder(root.left, output)
    preorder(root.right, output)
    return output
    # visit root
    # visit left subtree
    # visit right subtree
  end

  def postorder(root = @root, output = [])
    return if root.nil?

    postorder(root.left, output)
    postorder(root.right, output)
    if block_given?
      yield(root.data)
    else
      output << root.data
    end
    return output
  end

  def height(node = @root)
    # accepts a node and returns its height
    # the number of edges in longest path from a given node to a leaf node.

    # traverse both left and right subtree. check which is longest.
    return -1 if node.nil?

    left = height(node.left)
    right = height(node.right)

    return left > right ? left + 1 : right + 1 
  end

  def depth(node, root = @root)
    # accepts a node and returns its depth
    # the number of edges in path from a given node to the tree’s root node.
    
    return -1 if root.nil?
    return 0 if root.data == node

    left = depth(node, root.left)
    return left + 1 if left >= 0
    right = depth(node, root.right)
    return right + 1 if right >= 0

    return -1
  end

  def balanced?(node = @root)
    return true if node.nil?

    diff = (height(node.left) - height(node.right)).abs
    # return false if diff > 1
    # balanced?(left.left, left.right) unless height(left).zero?
    # balanced?(right.left, right.right) unless height(right).zero?

    return true if diff <= 1 && balanced?(node.left) && balanced?(node.right)

    return false
    # check the difference between height of right and height of left
    # false? return false
    # true? check if height of right.right == right.left.
    # stop when right.right and right.left are both null (reached leaf?)

    # some cases.
    # node doesn't have kids. left.left and left.right will be nil. height is 0.
    # node has a kid. either left.left or left.right will be nil. height is 1+.
    # node has two kids. both left.left and left.right have a value. height is 1+.
  end

  def rebalance
    @array = inorder
    @root = build_tree()
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end