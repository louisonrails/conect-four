class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def drop_disc(column, symbol)
    row = @grid.rindex { |r| r[column].nil? }
    @grid[row][column] = symbol
  end
end