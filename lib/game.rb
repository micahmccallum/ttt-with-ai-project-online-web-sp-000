class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize(player_1 = Players::Human.new("X"),
                 player_2 = Players::Human.new("O"),
                 board = Board.new)
    self.player_1 = player_1
    self.player_2 = player_2
    self.board = board
  end

  def current_player
    board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
    win = nil
    WIN_COMBINATIONS.each do |combo|
      win = combo if board.cells[combo[0]] == board.cells[combo[1]] &&
                     board.cells[combo[0]] == board.cells[combo[2]] &&
                     ["X", "O"].include?(board.cells[combo.first])
    end
    win
  end

  def draw?
    board.full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    board.cells[won?.first] unless !won?
  end

  def turn
    player = current_player
    input = player.move(board)
    if !board.valid_move?(input)
      turn
    end
    board.update(input, player) if !board.taken?(input)
  end

  def play
    while !won? && !over?
      turn
    end
    puts (draw? ? "Cat's Game!" : "Congratulations #{winner}!")
  end

end
