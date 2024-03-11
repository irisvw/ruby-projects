class Cell
  attr_accessor :value
  attr_reader :col, :row

  def initialize(value, col, row)
    @value = value
    @col = col
    @row = row
  end

  def is_empty?
    return (@value == " ")
  end
end