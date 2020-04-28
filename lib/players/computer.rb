module Players
  class Computer < Player

    def move(board)
      @board = board
      @opponent_token = self.opponent_token
      get_input
    end

    def get_input
      @input = nil
      int = nil
      if @board.turn_count == 0
        int = [Board::CORNERS.sample, Board::CENTER].sample
      elsif @board.turn_count == 1
        @board.taken?("5") ? int = Board::CORNERS.sample : int = Board::CENTER
      elsif can_win?
        int = win
      elsif can_block?
        int = block
      elsif can_play_two_in_a_row?
        int =  two_in_a_row
      else
        int = [Board::CORNERS.sample, Board::EDGES.sample].sample
      end
      input = index_to_input(int) if int
    end

    def can_play_two_in_a_row?
      @two_in_a_row_combo = false
      Game::WIN_COMBINATIONS.each do |combo|
        temp_array = []
        combo.each do |position|
          temp_array << @board.cells[position]
        end
        temp_array.sort!
        @two_in_a_row_combo = combo if temp_array == [" ", " ", "#{token}"]
      end
      @two_in_a_row_combo
    end

    def can_win?
      @win_combo = false
      Game::WIN_COMBINATIONS.each do |combo|
        temp_array = []
        combo.each do |position|
          temp_array << @board.cells[position]
        end
        temp_array.sort!
        @win_combo = combo if temp_array == [" ", "#{token}", "#{token}"]
      end
      @win_combo
    end

    def can_block?
      @block_combo = false
      Game::WIN_COMBINATIONS.each do |combo|
        temp_array = []
        combo.each do |position|
          temp_array << @board.cells[position]
        end
        temp_array.sort!
        @block_combo = combo if temp_array == [" ", "#{@opponent_token}", "#{@opponent_token}"]
      end
      @block_combo
    end

    def two_in_a_row
      @two_in_a_row_combo.reject {|cell| @board.cells[cell] == self.token}.sample
    end

    def win
      @win_combo.sample.reject {|position| @board.cells[position] == self.token }.sample
    end

    def block
      @block_combo.find {|cell| @board.cells[cell] == " "}
    end

    def index_to_input(int)
      (int += 1).to_s if int
    end

    def opponent_token
      Player::TOKENS.find {|toquen| toquen != token}
    end

  end
end
