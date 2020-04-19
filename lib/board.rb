class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = Array.new(9, " ")
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
    ["X", "O"].include?(position(input)) ? true : false
  end

  def full?
    @cells.all? {|index| taken?(index) }
  end

  def turn_count
    (@cells.find_all {|cell| ["X", "O"].include?(cell)}).count
  end

  def valid_move?(input)
    int = Integer(input) rescue false
    int.between?(0, 8) && !self.taken?(input) if int
  end

  def update(input, player)
    @cells[input.to_i - 1] = player.token
  end
end
