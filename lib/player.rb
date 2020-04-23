class Player
  attr_reader :token

  TOKENS = ["X", "O"]
  def initialize(token)
    @token = token
  end
end
