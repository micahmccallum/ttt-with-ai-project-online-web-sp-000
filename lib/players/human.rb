module Players
  class Human < Player

    def initialize(token)
      @token = token
    end

    def move(board)
      puts "Choose a position to play(1-9)."
      input = gets.strip
      input
    end
  end
end
