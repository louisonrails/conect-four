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

  def win_combination?(symbol)
    vertical_win?(symbol) || horizontal_win?(symbol) || diagonal_win?(symbol)
  end

  def vertical_win?(symbol)
    (0...7).any? do |col|
      count = 0

      (0...6).each do |row|
        if @grid[row][col] == symbol
          count += 1
          return true if count == 4
        else
          count = 0
        end
      end
      false
    end
  end

  def horizontal_win?(symbol)
    (0...6).any? do |row|
      count = 0

      (0...7).each do |col|
        if @grid[row][col] == symbol
          count += 1
          return true if count == 4
        else
          count = 0
        end
      end
      false
    end
  end

  def diagonal_win?(symbol)
    left_to_right_diagonal?(symbol) || right_to_left_diagonal?(symbol)
  end

  def left_to_right_diagonal?(symbol)
    (0..2).any? do |row|
      (0..3).any? do |col|
        (0..3).all? do |i|
          @grid[row + i][col + i] == symbol
        end
      end
    end
  end

  def right_to_left_diagonal?(symbol)
    (0..2).any? do |row|
      (3..6).any? do |col|
        (0..3).all? do |i|
          @grid[row + i][col - i] == symbol
        end
      end
    end
  end

end