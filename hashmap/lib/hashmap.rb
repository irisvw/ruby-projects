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
      # find key
      # override value
    else
      @buckets[index].append(key, value)
    end
  end

  def grow
    # we create a new buckets list that is double the size of the old buckets list, 
    # then we copy all nodes over to the new buckets.
    @capacity *= 2
    old_buckets = entries
    clear
    old_buckets.each { |entry| set(entry[0], entry[1])}
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
    # returns the number of stored keys in the hash map.
    entries.length
  end

  def clear
    # removes all entries in the hash map.
    @buckets = Array.new(@capacity) {LinkedList.new()}
  end

  def keys
    # get all stored keys
    array = entries
    keys = array.map { |entry| entry[0] }
    keys
  end

  def values
    # get all values from stored keys
    array = entries
    values = array.map { |entry| entry[1]}
    values
  end

  def entries
    # get each key value pair
    array = @buckets.select { |entry| entry.size != 0 } 
    pairs = array.map { |entry| entry.pairs}
    pairs.flatten(1)
  end
end
