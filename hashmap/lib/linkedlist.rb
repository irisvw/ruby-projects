class LinkedList
  # represents the full list
  def initialize
    @head = nil
  end

  def append(key, value)
    # adds a new node containing value to the end of the list
    if @head.nil?
      @head = Node.new(key, value)
    else
      tail.next_node = Node.new(key, value)
    end
  end

  def prepend(key, value)
    # adds a new node containing value to the start of the list
    if @head.nil?
      @head = Node.new(key, value)
    else
      node = Node.new(key, value)
      node.next_node = @head
      @head = node
    end
  end

  def size
    # returns the total number of nodes in the list
    return 0 if @head.nil?

    current_node = @head
    count = 1
    until current_node.next_node.nil?
      count += 1
      current_node = current_node.next_node
    end
    return count
  end

  def head
    # returns the first node in the list
    return nil if @head.nil?

    return @head
  end

  def tail
    # returns the last node in the list
    return nil if @head.nil?

    current_node = @head
    current_node = current_node.next_node until current_node.next_node.nil?
    return current_node
  end

  def at(index)
    # returns the node at the given index
    return nil if @head.nil?

    current_node = @head
    while index > 0
      current_node = current_node.next_node
      index -= 1
      return nil if current_node.next_node.nil?
    end
    return current_node.value
  end

  def pop
    # removes the last element from the list
    return nil if @head.nil?

    current_node = @head
    until current_node.next_node.nil?
      last_current_node = current_node
      current_node = current_node.next_node 
    end
    last_current_node.next_node = nil
  end

  def contains?(key)
    # returns true if the passed in key is in the list and otherwise returns false
    return false if @head.nil?

    current_node = @head
    while current_node.key != key
      return false if current_node.next_node.nil?
      current_node = current_node.next_node
    end
    return true
  end

  def find(key)
    # returns the index of the node containing value, or nil if not found
    return nil if @head.nil?

    current_node = @head
    index = 0
    while current_node.key != key
      return nil if current_node.key != key && current_node.next_node.nil?
      current_node = current_node.next_node
      index += 1
    end
    return index
  end

  def to_s
    # ( value ) -> ( value ) -> ( value ) -> nil
    return if @head.nil?

    current_node = @head
    output = "( #{current_node.value} ) -> "
    loop do
      if current_node.next_node.nil?
        output << "nil"
        puts output
        return
      else
        current_node = current_node.next_node
        output << "( #{current_node.value} ) -> "
      end
    end
    puts output
  end

  def insert_at(key, value, index)
    # inserts a new node with the provided value at the given index.
    return nil if index > self.size

    if index == 0
      prepend(value)
    else
      current_node = @head
      while index > 0
        previous_node = current_node
        current_node = current_node.next_node
        index -= 1
      end
      new_node = Node.new(key, value)
      previous_node.next_node = new_node
      new_node.next_node = current_node
    end
  end

  def remove_at(index)
    # removes the node at the given index.
    return nil if index > self.size

    current_node = @head

    if index == 0
      @head = current_node.next_node
      return current_node.value
    else
      while index > 0
        previous_node = current_node
        current_node = current_node.next_node
        index -= 1
      end
      previous_node.next_node = current_node.next_node
      return previous_node.value
    end
  end

  def keys
    return nil if @head.nil?

    current_node = @head
    output = [current_node]
    loop do
      if current_node.next_node.nil?
        output << output # THIS IS WHERE YOU LEFT OFF
        return
      else
        current_node = current_node.next_node
        output << "( #{current_node.value} ) -> "
      end
    end
    puts output
  end
  
  def values
  end 
end

class Node
  attr_accessor :next_node, :key, :value
  #  holds a single element of data and a link or pointer to the next node in the list.

  def initialize(key, value = nil)
    @next_node = nil
    @key = key
    @value = value
  end

  def to_s
    puts "#{key}: #{@value}"
  end
end