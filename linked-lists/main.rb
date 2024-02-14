class LinkedList
  # represents the full list
  def initialize
    @head = nil
  end

  def append(value)
    # adds a new node containing value to the end of the list
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end
  end

  def prepend(value)
    # adds a new node containing value to the start of the list
    if @head.nil?
      @head = value
      @tail = value
    else
      node = Node.new(value)
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

    return @head.value
  end

  def tail
    # returns the last node in the list
    return nil if @head.nil?

    current_node = @head
    current_node = current_node.next_node until current_node.next_node.nil?
    return current_node.value
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
    @tail = last_current_node
    @tail.next_node = nil
  end

  def contains?(value)
    # returns true if the passed in value is in the list and otherwise returns false
    return false if @head.nil?

    current_node = @head
    while current_node.value != value
      current_node = current_node.next_node
      return false if current_node.next_node.nil?
    end
    return true
  end

  def find(value)
    # returns the index of the node containing value, or nil if not found
    return nil if @head.nil?

    current_node = @head
    index = 0
    while current_node.value != value
      current_node = current_node.next_node
      index += 1
      return nil if current_node.value != value && current_node.next_node.nil?
    end
    return index
  end

  def to_s
    # ( value ) -> ( value ) -> ( value ) -> nil
    current_node = @head
    output = "( #{current_node.value} ) -> "
    while current_node.next_node.nil? == false
      current_node = current_node.next_node
      output << "( #{current_node.value} ) -> "
    end
    puts output
  end

  def insert_at(value, index)
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
      new_node = Node.new(value)
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
      return current_node
    else
      while index > 0
        previous_node = current_node
        current_node = current_node.next_node
        index -= 1
      end
      previous_node.next_node = current_node.next_node
    end
  end
end

class Node
  attr_accessor :next_node, :value
  #  holds a single element of data and a link or pointer to the next node in the list.

  def initialize(value = nil)
    @next_node = nil
    @value = value
  end
end

# test driven development before i learn test driven development
my_list = LinkedList.new()
my_list.append("eevee")
my_list.append("flareon")
my_list.append("sylveon")

puts "tests (contains?) expect true, false"
p my_list.contains?("flareon")
p my_list.contains?("umbreon")
puts ""

puts "tests (find) expect 0, 2, nil"
p my_list.find("eevee")
p my_list.find("sylveon")
p my_list.find("umbreon")
puts ""

puts "tests (prepend) expect 0, 0"
my_list.prepend("umbreon")
p my_list.find("umbreon")
my_list.prepend("espeon")
p my_list.find("espeon")
puts ""

puts "tests (head) expect 'espeon'"
p my_list.head
puts ""

puts "tests (tail) expect 'sylveon'"
p my_list.tail
puts ""

puts "tests (size, pop) expect 5, 4, 2"
p my_list.size
my_list.pop
p my_list.size
my_list.pop
my_list.pop
p my_list.size
puts ""

puts "tests (to_s) expect ( espeon ) -> ( umbreon ) -> nil"
p my_list.to_s
my_list.pop
p my_list.to_s
my_list.append("umbreon")
puts ""

puts "tests (insert_at) expect ( espeon ) -> ( glaceon ) -> ( umbreon ) -> ( jolteon ) -> nil "
my_list.insert_at("glaceon", 1)
my_list.insert_at("jolteon", 3)
p my_list.to_s
puts ""

puts "tests (remove_at) expect ( glaceon ) -> ( jolteon ) -> nil "
my_list.remove_at(0)
my_list.remove_at(1)
p my_list.to_s

p my_list.tail