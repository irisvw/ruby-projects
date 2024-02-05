def substrings(string, dictionary)
    result = Hash.new(0)
    array = string.downcase.split(" ")
    array.each do | value |
        i = 0
        while i < dictionary.length do
            if (value.include?(dictionary[i]))
                result[dictionary[i]] += 1
            end
            i += 1
        end
    end
    p result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
