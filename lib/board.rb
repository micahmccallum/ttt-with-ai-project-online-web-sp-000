class Board
  attr_accessor :cells

  def initialize
    self.cells = Array.new(9, " ")
  end

  def reset!
    self.cells = (Board.new).cells
  end

  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end

  def position(input)
    self.cells[input.to_i - 1]
  end

  def taken?(input)
    ["X", "O"].include?(position(input)) ? true : false
  end

  def full?
    self.cells.all? {|index| taken?(index) }
  end

  def turn_count
    (self.cells.find_all {|cell| ["X", "O"].include?(cell)}).count
  end

  def valid_move?(input)
    int = Integer(input) rescue false
    int.between?(0, 8) && !self.taken?(input) if int
  end

  def update(input, player)
    self.cells[input.to_i - 1] = player.token
  end
end
