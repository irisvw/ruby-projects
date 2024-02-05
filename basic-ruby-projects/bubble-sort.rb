def bubble_sort(array)
    x = array.length
    x.times do
        i = 0
        sorted_something = false
        while (i < array.length - 1)
            if (array[i] > array[i+1])
                array[i], array[i+1] = array[i+1], array[i]
                sorted_something = true
            end
            i += 1
        end
        unless sorted_something
            return array
        end
    end
    array
end

p bubble_sort([4, 3, 78, 2, 0, 2])