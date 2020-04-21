module Players
  class Human < Player

    def move(board)
      puts "Choose a position to play(1-9)."
      input = gets.strip
      input
    end
  end
end
