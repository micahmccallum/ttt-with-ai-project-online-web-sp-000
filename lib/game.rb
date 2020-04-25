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
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    @board.turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def won?
    win = false
    WIN_COMBINATIONS.each do |combo|
      win = combo if @board.cells[combo[0]] == @board.cells[combo[1]] &&
                     @board.cells[combo[0]] == @board.cells[combo[2]] &&
                     ["X", "O"].include?(board.cells[combo.first])
    end
    win
  end

  def draw?
    @board.full? && !self.won?
  end

  def over?
    self.draw? || self.won?
  end

  def winner
    @board.cells[self.won?.first] unless !self.won?
  end

  def turn
    input = self.current_player.move(board)
    if !@board.valid_move?(input)
      self.turn
    end
    @board.update(input, self.current_player) if !@board.taken?(input)
  end

  def play
    while !self.over?
      self.board.display
      self.turn
    end

    puts (self.draw? ? "Cat's Game!" : "Congratulations #{self.winner}!")
    self.board.display
  end

  def start
    self.game_init
    self.play
  end

  def game_init
    puts "Welcome to Ultimate Tic-Tac-Toe!"
    puts "Please choose a game mode:"
    puts "Choose 0 for two computer players."
    puts "Choose 1 for one human player and one computer player."
    puts "Choose 2 for 2 human players."
    input = gets.strip
    case input
    when "0"
      player_1 = Players::Computer.new(Player::TOKENS[0])
      player_2 = Players::Computer.new(Player::TOKENS[1])
    when "1"
      puts "Do you want to play first?  Enter 1 for yes and 0 for no."
      answer = gets.strip
      if answer == "0"
        player_1 = Players::Computer.new(Player::TOKENS[0])
      else
        player_2 = Players::Computer.new(Player::TOKENS[1])
      end
    when "2"
        true
    else
      game_init
    end
    @player_1 = player_1 if player_1
    @player_2 = player_2 if player_2

  end
end
