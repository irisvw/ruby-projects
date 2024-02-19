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
    mid = (start + finish) / 2 # 

    # set middle element as root
    root = Node.new(array[mid])

    # calculate mid of left_array, assign to left
    root.left = build_tree(array, start, mid-1)

    # calculate mid of right_array, assign to right
    root.right = build_tree(array, mid+1, finish)
    
    # return root as node
    return root
  end

  def insert
    # accepts value to insert
  end

  def delete
    # accepts value to delete
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end