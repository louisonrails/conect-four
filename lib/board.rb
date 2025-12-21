class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def drop_disc(column, symbol)
    raise StandardError if column_full?(column)

    row = @grid.rindex { |r| r[column].nil? }
    @grid[row][column] = symbol
  end

  def column_full?(column)
    @grid.all? { |row| row[column] != nil }
  end

  def full?
    @grid.flatten.none?(&:nil?)
  end
end