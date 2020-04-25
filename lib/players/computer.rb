module Players
  class Computer < Player

    def move(board)
      @board = board
      get_input(@board)

    end

    def get_input(board)
      @board = board
      @input = nil
      if @board.turn_count == 0
        int = [Board::CORNERS.sample, Board::CENTER].sample
      elsif @board.turn_count == 1
        @board.taken?("5") ? int = Board::CORNERS.sample : int = Board::CENTER
      else
        minmax
      end

    end






    def index_to_input(int)

      (int += 1).to_s if int
    end


  end
end
