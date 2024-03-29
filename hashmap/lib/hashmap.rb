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
    capacity = length / @capacity

    if capacity > @load_factor
      grow
    end

    if @buckets[index].contains?(key)
      key_index = @buckets[index].find(key)
      @buckets[index].update(key_index, value)
    else
      @buckets[index].append(key, value)
    end
  end

  def grow
    # doubles capacity of buckets, copies all nodes over
    @capacity *= 2
    old_buckets = entries
    clear
    old_buckets.each { |entry| set(entry[0], entry[1])}
  end

  def get(key)
    # returns the value that is assigned to the given key
    index = get_index(key)

    return nil if @buckets[index].size == 0 || @buckets[index].contains?(key) == false
    
    key_index = @buckets[index].find(key)
    @buckets[index].at(key_index).value
  end

  def has?(key)
    # returns true or false based on whether or not the given key is in the hash map.
    index = get_index(key)

    return @buckets[index].contains?(key)
  end

  def remove(key)
    # removes the entry with the given key and return the deleted entry’s value.
    index = get_index(key)

    return nil if @buckets[index].size == 0 || @buckets[index].contains?(key) == false

    key_index = @buckets[index].find(key)
    @buckets[index].remove_at(key_index)
  end

  def length
    # returns the number of stored keys in the hash map.
    entries.length
  end

  def clear
    # removes all entries in the hash map.
    @buckets = Array.new(@capacity) {LinkedList.new()}
  end

  def keys
    # returns an array containing all the keys inside the hash map.
    array = entries
    keys = array.map { |entry| entry[0] }
    keys
  end

  def values
    # returns an array containing all the values.
    array = entries
    values = array.map { |entry| entry[1]}
    values
  end

  def entries
    # returns an array that contains each key, value pair.
    array = @buckets.select { |entry| entry.size != 0 } 
    pairs = array.map { |entry| entry.pairs}
    pairs.flatten(1)
  end
end
