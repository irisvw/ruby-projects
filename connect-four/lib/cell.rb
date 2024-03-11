class Cell
  attr_accessor :value
  attr_reader :row, :col

  def initialize(row, col)
    @row = row
    @col = col
    @value = " "
  end

  def free?
    return @value == " "
  end
end