class Cell
  attr_accessor :value
  attr_reader :row, :col

  def initialize(col, row)
    @col = col
    @row = row
    @value = " "
  end

  def free?
    return @value == " "
  end
end