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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end