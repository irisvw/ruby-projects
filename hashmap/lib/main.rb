require_relative 'linkedlist.rb'
require_relative 'hashmap.rb'

# tests

map = HashMap.new()
map.set("George", "Potter")
map.set("Fred", "Smith")
map.set("John", "Doe") # john shares a bucket with fred.

map.grow

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
puts "expect: 2"
p map.length
puts ""

puts "test: length"
puts "expect: 3"
map.set("George", "Potter")
p map.length
puts ""

puts "test: keys"
puts "expect: [['Fred', 'John'], 'George']"
p map.keys
puts ""

puts "test: values"
puts "expect: [['Smithy', 'Doe'], 'Potter']"
p map.values
puts ""

puts "test: entries"
puts "expect: [['Fred', 'Smithy'], ['John', 'Doe'], ['George', 'Potter']]"
p map.entries
puts ""

puts "test: clear"
puts "expect: 0"
map.clear
p map.length
puts ""
