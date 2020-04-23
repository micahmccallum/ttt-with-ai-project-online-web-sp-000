module Players
  class Computer < Player

    def move(board)
      @board = board

      if first_move?
        index = Board::CORNERS.sample
      elsif two_in_a_row?(@token)
        index = two_in_a_row?(@token)
      elsif two_in_a_row?(opponent_token)
        index = two_in_a_row?(opponent_token)
      elsif false #check for opportunity to fork
        #play to fork
      elsif false# If there is only one possible fork for the opponent, the player should block it. Otherwise, the player should block all forks in any way that simultaneously allows them to create two in a row. Otherwise, the player should create a two in a row to force the opponent into defending, as long as it doesn't result in them creating a fork. For example, if "X" has two opposite corners and "O" has the center, "O" must not play a corner in order to win.
        #play block
      elsif false
        index = 4
      elsif false#check for opponent corner move
        #play opposite corner
      elsif false#play any corner if valid_move
        index = Board::CORNERS.sample
      else
        index = Board::EDGES.sample
      end
      self.to_input(index)
    end

    def first_move?
      @board.empty?
    end

    def two_in_a_row?(token)
      input = false
      Game::WIN_COMBINATIONS.each do |combo|
        matching = combo.find_all {|position| @board[position] == token}
        input = combo.find {|position| @board[position] == " "} if matching.count == 2
      end
      input
    end

    def opponent_token
      ["X", "O"].reject(@token)
    end

    def to_input(index)
      (index + 1).to_s
    end

    # def fork_opportunity(token)
    #   @board.each do |cell|
    #     Game::WIN_COMBINATIONS.each do |combo|
    #
    #     end
    #   end
    # end
  end
end
