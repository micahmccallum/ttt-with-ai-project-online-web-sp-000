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
      elsif @board.turn_count == 2
        int = two_in_a_row
      elsif can_win?
        int = win
      elsif can_block?
        int = block
      else
        int = [Board::CORNERS.sample, Board::EDGES.sample].sample
      end
      input = index_to_input(int) if int
    end

    def two_in_a_row
      saved_combo = []
      temp_saved_combo = []
      Game::WIN_COMBINATIONS.each do |combo|
        temp_cells = []
        combo.each do |cell|
          temp_cells << cell if @board.cells[cell] == self.token
        end
        temp_saved_combo << combo if temp_cells.count > 0
      end
      opponent_moves = []
      @board.cells.each_with_index do |cell, index|
        opponent_moves << index if cell == opponent_token
      end
      temp_saved_combo.each do |combo|
        saved_combo << combo unless combo.include?(opponent_moves.first)
      end
      (saved_combo.sample).reject {|cell| @board.cells[cell] == self.token}.sample
    end

    def can_block?
      opponent_moves = []
      @board.cells.each_with_index do |cell, index|
        opponent_moves << index if cell == opponent_token
      end
      Game::WIN_COMBINATIONS.each do |combo|
        position_count = 0
        combo.each do |position|
          position_count += 1 if opponent_moves.include?(position)

        end
        @block_combo = combo if position_count > 1 && combo.include?(" ")

      end
      @block_combo ? true : false
    end

    def block
      input = @block_combo.reject {|cell| @board.cells[cell] == opponent_token}.sample

    end

    def can_win?
      token_count = 0
      Game::WIN_COMBINATIONS.each do |combo|
        token_count = 0
        combo.each do |position|
          token_count += 1 if @board.cells[position] == token
        end
        @win_combo = combo if token_count > 1 && combo.include?(" ")
      end
      @win_combo ? true : false
    end

    def win
      @win_combo.reject {|position| @board.cells[position] == token }.sample
    end

    def index_to_input(int)
      (int += 1).to_s if int
    end

    def opponent_token
      TOKENS.reject{|toquen| toquen == token}.sample
    end


  end
end
