stock = [17,3,6,9,15,8,6,1,10]

def stock_picker(stock_prices)
    stock_prices_h = []

    stock_prices.each_with_index do |buy, buy_index|
        stock_prices.each_with_index do |sell, sell_index|
            if (sell_index > buy_index)
                profit = sell - buy
                stock_prices_h << {:buy => buy_index, :sell => sell_index, :profit => profit}
            end
        end
    end

    puts stock_prices_h.max_by{|x| x[:profit]}
end

stock_picker(stock)