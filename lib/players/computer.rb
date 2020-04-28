module Players
  class Computer < Player

    def move(board)
      @board = board
      @opponent_token = self.opponent_token
      get_input
    end

    def get_input
      @input = nil
      if @board.turn_count == 0
        int = [Board::CORNERS.sample, Board::CENTER].sample
      elsif @board.turn_count == 1
        @board.taken?("5") ? int = Board::CORNERS.sample : int = Board::CENTER
      elsif self.can_win?
        int = self.win
      elsif self.can_block?
        int = self.block
      elsif self.can_play_two_in_a_row?
        int = self.two_in_a_row
      else
        
        int = [Board::CORNERS.sample, Board::EDGES.sample].sample
      end
      input = index_to_input(int) if int
    end

    def can_play_two_in_a_row?
      Game::WIN_COMBINATIONS.each do |combo|
        temp_array = []
        combo.each do |position|
          temp_array << @board.cells[position]
        end
        temp_array.sort!
        if temp_array == [" ", " ", "#{token}"]
          @two_in_a_row_combo = combo
          true
        else
          false
        end
      end
    end


    def can_win?
      Game::WIN_COMBINATIONS.each do |combo|
        temp_array = []
        combo.each do |position|
          temp_array << @board.cells[position]
        end
        temp_array.sort!
        if temp_array == [" ", "#{token}", "#{token}"]
          @win_combo = combo
          true
        else
          false
        end
      end
    end

    def can_block?
      Game::WIN_COMBINATIONS.each do |combo|
        temp_array = []
        combo.each do |position|
          temp_array << @board.cells[position]
        end
        temp_array.sort!
        if temp_array == [" ", "#{@opponent_token}", "#{@opponent_token}"]
          @block_combo = combo
          true
        else
          false
        end
      end
    end

    def two_in_a_row
        puts "2 in a row"
      @two_in_a_row_combo.reject {|cell| @board.cells[cell] == self.token}.sample
    end

    def win
      puts "win"
      @win_combo.sample.reject {|position| @board.cells[position] == self.token }.sample
    end

    def block
        puts "block"
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
