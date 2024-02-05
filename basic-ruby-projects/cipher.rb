def caesar_cipher (string, shift)
    string_unicode = string.split("").map { | value | value.ord }
    new_array = []

    string_unicode.each do |value|
        new_value = value + shift
        if (value.between?(65, 90))
            if (new_value > 90)
                new_value -= 26
            end
            new_array << new_value
        elsif (value.between?(97, 122))
            if (new_value > 122)
                new_value -= 26
            end
            new_array << new_value
        else
            new_array << value
        end
    end

    string_cipher = new_array.map{ |value| value.chr }.join
    p string_cipher
end
