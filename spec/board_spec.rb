require_relative '../lib/board'

RSpec.describe Board do
  it 'initializes with a 6x7 grid' do
    board = described_class.new

    expect(board.grid.size).to eq(6)
    expect(board.grid.all? { |row| row.size == 7 }).to be true
  end

  it 'starts with all cells empty' do
    board = described_class.new

    expect(board.grid.flatten).to all(be_nil)
  end

  describe '#drop_disc' do
    it 'drops a disc into the bottom row of a column' do
      board = described_class.new

      board.drop_disc(0, 'X')

      expect(board.grid[5][0]).to eq('X')
    end

    it 'stacks discs from bottom to top in a column' do
      board = described_class.new

      board.drop_disc(0, 'X')
      board.drop_disc(0, 'O')

      expect(board.grid[5][0]).to eq('X')
      expect(board.grid[4][0]).to eq('O')
    end
  end

  describe '#column_full?' do
    it 'returns true when a column is full' do
      board = described_class.new

      6.times { board.drop_disc(0, 'X') }

      expect(board.column_full?(0)).to be true
    end

    it 'returns false when a column is not full' do
      board = described_class.new

      board.drop_disc(0, 'X')

      expect(board.column_full?(0)).to be false
    end

    it 'raises an error when dropping into a full column' do
      board = described_class.new
      6.times { board.drop_disc(0, 'X') }

      expect { board.drop_disc(0, 'O') }
        .to raise_error(StandardError)
    end
  end

  describe '#full?' do
    it 'returns true when the board is full' do
      board = described_class.new

      7.times do |col|
        6.times { board.drop_disc(col, 'X') }
      end

      expect(board.full?).to be true
    end
  end
end