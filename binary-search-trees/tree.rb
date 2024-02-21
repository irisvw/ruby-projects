class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree
  end

  def build_tree(array = @array, start = 0, finish = @array.length - 1)
    return nil if start > finish

    mid = (start + finish) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array, start, mid-1)
    root.right = build_tree(array, mid+1, finish)
    return root
  end

  def insert(value, root = @root)
    return Node.new(value) if root.nil?

    if root.data == value
      return root
    elsif root.data < value
      root.right = insert(value, root.right)
    else
      root.left = insert(value, root.left)
    end

    return root
  end

  def delete(value, root = @root)
    return root if root.nil?

    # recursion
    if root.data < value
      root.right = delete(value, root.right)
      return root
    elsif root.data > value
      root.left = delete(value, root.left)
      return root
    end

    # if node has zero or one child
    if root.left.nil?
      root = root.right 
      return root
    elsif root.right.nil?
      root = root.left
      return root
    else
      # if node has two children
      parent_root = root
      next_root = root.right
      while next_root.left != nil
        parent_root = next_root
        next_root = next_root.left
      end

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
    return nil if root.nil?

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
    return -1 if node.nil?

    left = height(node.left)
    right = height(node.right)

    return left > right ? left + 1 : right + 1 
  end

  def depth(node, root = @root)
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
    return true if diff <= 1 && balanced?(node.left) && balanced?(node.right)

    return false
  end

  def rebalance
    @array = inorder
    @root = build_tree()
  end

  # method written by fensus on the TOP discord.
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end