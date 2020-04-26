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
      elsif @board.turn_count == 3
        int = block
      end
      input = index_to_input(int) if int
    end

    def two_in_a_row
      saved_combo = []
      temp_saved_combo = []
      position = nil
      Game::WIN_COMBINATIONS.each do |combo|
        combo.each do |position|
          temp_saved_combo << combo.reject {|int| int == position}  if @board.cells[position] == token
        end
      end
      opponent_moves = @board.cells.find_all {|cell| cell == opponent_token}
      temp_saved_combo.each do |combo|
        saved_combo << combo unless combo.include?(opponent_moves)
      end
      (saved_combo.sample).sample
    end

    def block
      temp_saved_combo = []
      saved_combo = []
      Game::WIN_COMBINATIONS.each do |combo|
        combo.each do |position|
          temp_saved_combo << combo if @board.cells[position == opponent_token]
        end
      end
      temp_saved_combo.each do |combo|
        combo.each do |postion|
          saved_combo << combo if
        end
      end

    end

    def index_to_input(int)
      (int += 1).to_s if int
    end

    def opponent_token
      TOKENS.reject{|toquen| toquen == token}
    end


  end
end
