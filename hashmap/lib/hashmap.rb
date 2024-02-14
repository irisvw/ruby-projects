#raise IndexError if index.negative? || index >= @buckets.length
require_relative 'linkedlist.rb'

class HashMap
  def initialize
    @buckets = Array.new
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % 16
    if @buckets[index].nil?
      @buckets[index] = Node.new(key, value)
    elsif @buckets[index].key == key
      @buckets[index].value = value
    end
  end

  def get(key)
    index = hash(key) % 16
    return if @buckets[index].nil?
    
    if @buckets[index].key == key
      return @buckets[index].value
    else
      return nil
    end
  end

  def has?(key)
    index = hash(key) % 16
    return @buckets[index].nil? ? false : true
  end

  def remove(key)
    index = hash(key) % 16
    return nil if @buckets[index].nil?
    value = @buckets[index].value
    @buckets.delete_at(index)
    value
  end

  def length
    return @buckets.compact.length
  end

  def clear
    @buckets.clear
  end

  def keys
    array = []
    @buckets.compact.each { |element| array << element.key } 
    array
  end

  def values
    array = []
    @buckets.compact.each { |element| array << element.value } 
    array
  end

  def entries
    array = []
    @buckets.compact.each { |element| array << "[#{element.key}, #{element.value}]" } 
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