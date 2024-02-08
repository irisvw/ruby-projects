module Enumerable
  def my_each_with_index
    # With a block given, calls the block with each element and its index; returns self:
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    # Returns an array containing elements selected by the block.
    # With a block given, calls the block with successive elements; returns an array of those elements for which the block returns a truthy value:
    arr = []
    self.my_each do |element|
      arr << element if yield(element)
    end
    arr
  end

  def my_all?
    # Returns whether every element meets a given criterion.
    arr = []
    self.my_each do |element|
      arr << element if yield(element)
    end
    return arr.length == self.length ? true : false
  end

  def my_any?
    arr = []
    self.my_each do |element|
      arr << element if yield(element)
    end
    return arr.length >= 1 ? true : false
  end

  def my_none?
    arr = []
    self.my_each do |element|
      arr << element if yield(element)
    end
    return arr.length == 0 ? true : false
  end

  def my_count
    arr = []
    if block_given?
      self.my_each do |element|
        arr << element if yield(element)
      end
      return arr.length
    end
    return self.length
  end

  def my_map
    arr = []
    self.my_each do |element|
      arr << yield(element)
    end
    arr
  end

  def my_inject(sum = 0)
    self.my_each do |element|
      sum = yield(sum, element)
    end
    sum
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end

    self
  end
end
