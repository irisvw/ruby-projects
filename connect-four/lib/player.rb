class Player
  attr_reader :token, :name
  
  def initialize(name, token)
    @token = token
    @name = name
  end
end