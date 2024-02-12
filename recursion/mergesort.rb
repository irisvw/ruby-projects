def merge_sort(arr, sorted = [])
  if arr.length <= 1
    return arr
  else
    left = merge_sort(arr[... (arr.length / 2)])
    right = merge_sort(arr[((arr.length / 2)) ..])

    while !(left.empty? && right.empty?) 
      if left.empty?
        sorted << right.first
        right.shift
      elsif right.empty?
        sorted << left.first
        left.shift 
      elsif left.first <= right.first
        sorted << left.first
        left.shift
      elsif right.first <= left.first
        sorted << right.first
        right.shift
      end
    end
    return sorted
  end
end

p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
p merge_sort([105, 79, 100, 110])