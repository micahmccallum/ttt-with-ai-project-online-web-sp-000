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
      elsif can_win?
        int = win
      elsif can_block?
        int = block
      elsif can_play_two_in_a_row?
        int = two_in_a_row
      else
        int = [Board::CORNERS.sample, Board::EDGES.sample].sample
      end
      input = index_to_input(int) if int
    end

    def can_play_two_in_a_row?
      Game::WIN_COMBINATIONS.each do |combo|
        token_count = 0
        opponent_token_count = 0
        combo.each do |cell|
          combo_cell = @board.cells[cell]
          if combo_cell == token
            token_count += 1
          elsif combo_cell == @opponent_token
            opponent_token_count += 1
          end
        end
        @two_in_a_row_combo = combo if token_count > 0 && opponent_token_count == 0
         end
      @two_in_a_row_combo ? true : false
    end

    def can_win?
      @win_combo = false
      Game::WIN_COMBINATIONS.each do |combo|
        token_count = 0
        tokens = []
        combo.each do |position|
          token_count += 1 if @board.cells[position] == token
          tokens << @board.cells[position]
        end
        @win_combo = combo if token_count == 2 && tokens.include?(token)
      end
      @win_combo ? true : false
    end

    def can_block?
      @block_combo = false
      Game::WIN_COMBINATIONS.each do |combo|
        temp_array = []
        combo.each do |position|
          temp_array << @board.cells[position]
        end
        temp_array.sort!
        @block_combo = combo if temp_array == [" ", @opponent_token, @opponent_token]
      end

      #   opponent_moves = []
      #   blank_cells = []
      #   combo.each do |position|
      #     opponent_moves << position if @board.cells[position] == @opponent_token
      #     blank_cells << position if @board.cells[position] == " "
      #   end
      #   @block_combo = combo if opponent_moves.count == 2 && blank_cells.count == 1
      # end
      @block_combo ? true : false
    end

    def two_in_a_row
      @two_in_a_row_combo.reject {|cell| @board.cells[cell] == self.token}.sample
    end

    def win
      binding.pry
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
