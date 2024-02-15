require_relative 'linkedlist.rb'

class HashMap
  def initialize
    @capacity = 16
    @buckets = Array.new(@capacity, LinkedList.new())
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def get_index(key)
    index = hash(key) % 16
    raise IndexError if index.negative? || index >= @buckets.length
    index
  end

  def set(key, value)
    index = get_index(key)
    @buckets[index].append(key, value)
    # if @buckets[index].head.nil?
    #   @buckets[index].append(Node.new(key, value))
    # # elsif @buckets[index].head.key == key
    # #   @buckets[index].head.value = value
    # else
    #   current_node = @buckets[index].head
    #   current_node = current_node.next_node until current_node.next_node == nil
    #   current_node.append(Node.new(key, value))
    # end
  end

  def get(key)
    index = get_index(key)

    return nil if @buckets[index].size == 0 || @buckets[index].contains?(key) == false
    
    key_index = @buckets[index].find(key)
    value = @buckets.at(key_index)
    value
  end

  def has?(key)
    index = get_index(key)

    return @buckets[index].contains?(key) ? false : true
  end

  def remove(key)
    index = get_index(key)

    return nil if @buckets[index].size == 0 || @buckets[index].contains?(key) == false

    key_index = @buckets[index].find(key)
    @buckets[index].remove_at(key_index)
  end

  def length
    return @buckets.compact.length
  end

  def clear
    @buckets.clear
  end

  def keys
    array = @buckets.select { |entry| entry.size != 0 } 
    array
  end
  # one entry is a linkedlist, sometimes empty, sometimes containing one, two, or more elements. compact won't work anymore cause they're not nil.
  def values
    # array = []
    # @buckets.each { |entry| array << entry.value } 
    # array
    array = @buckets.select { |entry| entry.size != 0 } 
    array
  end

  def entries
    # array = []
    # @buckets.each { |entry| array << "[#{entry.key}, #{entry.value}]" } 
    # array
    array = @buckets.select { |entry| entry.size != 0 } 
    array
  end
end

# tests

map = HashMap.new()
map.set("George", "Potter")
map.set("Fred", "Smith")

puts "test: has?"
puts "expect: true"
p map.has?("Fred")
puts ""

puts "test: has?"
puts "expect: false"
p map.has?("Harry")
puts ""

puts "test: get"
puts "expect: Smith"
p map.get("Fred")
puts ""

puts "test: get"
puts "expect: nil"
p map.get("Harry")
puts ""

puts "test: set"
puts "expect: Smithy"
map.set("Fred", "Smithy")
p map.get("Fred")
puts ""

puts "test: remove"
puts "expect: Potter"
p map.remove("George")
puts ""

puts "test: length"
puts "expect: 1"
p map.length
puts ""

puts "test: length"
puts "expect: 2"
map.set("George", "Potter")
p map.length
puts ""

puts "test: keys"
puts "expect: ['Fred', 'George']"
p map.keys
puts ""

puts "test: values"
puts "expect: ['Smithy', 'Potter']"
p map.values
puts ""

puts "test: entries"
puts "expect: [['Fred', 'Smithy'], ['George', 'Potter']]"
p map.entries
puts ""

puts "test: clear"
puts "expect: 0"
map.clear
p map.length
puts ""

# each bucket is a linked list?
# if bucket is empty
# bucket head = node