class Board
  attr_accessor :cells

  CORNERS = [0, 2, 6, 8]
  EDGES = [1, 3, 5, 7]
  CENTER = 4

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = (Board.new).cells
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(input)
    @cells[input.to_i - 1]
  end

  def taken?(input)
    Player::TOKENS.include?(self.position(input)) ? true : false
  end

  def full?
    self.turn_count == 9
  end

  def turn_count

    (@cells.count - @cells.count(" "))
  end

  def valid_move?(input)
    int = Integer(input) rescue false
    int.between?(1, 9) && !self.taken?(input) if int
  end

  def update(input, player)
    @cells[input.to_i - 1] = player.token
  end

  def empty?
    @cells.all? {|cell| cell == " "}
  end
end
