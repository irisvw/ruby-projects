require_relative 'linkedlist.rb'

class HashMap
  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Array.new(@capacity) {LinkedList.new()}
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def get_index(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    index
  end

  def set(key, value)
    index = get_index(key)
    # check load factor
    # rehash if necessary
    if @buckets[index].contains?(key)
      # find key
      # override value
    else
      @buckets[index].append(key, value)
    end
  end

  def get(key)
    index = get_index(key)

    return nil if @buckets[index].size == 0 || @buckets[index].contains?(key) == false
    
    key_index = @buckets[index].find(key)
    @buckets[index].at(key_index)
  end

  def has?(key)
    index = get_index(key)

    return @buckets[index].contains?(key)
  end

  def remove(key)
    index = get_index(key)

    return nil if @buckets[index].size == 0 || @buckets[index].contains?(key) == false

    key_index = @buckets[index].find(key)
    @buckets[index].remove_at(key_index)
  end

  def length
    @buckets.select { |entry| entry.size != 0 }.length
    # count how many nodes in each entry as well
  end

  def clear
    @buckets.clear
  end

  def keys
    array = @buckets.select { |entry| entry.size != 0 }
    # get all stored keys
    array
  end

  def values
    array = @buckets.select { |entry| entry.size != 0 }
    # get all values from stored keys
    array
  end

  def entries
    array = @buckets.select { |entry| entry.size != 0 } 
    # get each key value pair 
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

# puts "test: values"
# puts "expect: ['Smithy', 'Potter']"
# p map.values
# puts ""

# puts "test: entries"
# puts "expect: [['Fred', 'Smithy'], ['George', 'Potter']]"
# p map.entries
# puts ""

puts "test: clear"
puts "expect: 0"
map.clear
p map.length
puts ""