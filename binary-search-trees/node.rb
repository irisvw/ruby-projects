class Node
  attr_accessor :right, :left, :data
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end