require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

RSpec.describe Game do
  describe '#initialize' do
    let(:board)   { Board.new }
    let(:player1) { Player.new('Dio', 'X') }
    let(:player2) { Player.new('Johnathan', 'O') }

    subject(:game) { described_class.new(board, player1, player2) }
    it 'initializes a game with each atribute' do

      expect(game.board).to eq(board)
      expect(game.player1).to eq(player1)
      expect(game.player2).to eq(player2)
    end

    it 'initializes current_player as player1' do
      expect(game.current_player).to eq(player1)
    end

    it 'initializes th winner as nil' do
      expect(game.winner).to be nil
    end
  end

  describe '#turn' do
    let(:board)   { Board.new }
    let(:player1) { Player.new('Dio', 'X') }
    let(:player2) { Player.new('Johnathan', 'O') }

    subject(:game) { described_class.new(board, player1, player2) }

    it 'expects the current_player to be player2' do
      game.turn_player
      expect(game.current_player).to eq(player2)
    end

    it 'expects the current_player to be player1 after 2 turns' do
      game.turn_player
      game.turn_player
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#game_over?' do
    let(:board)   { Board.new }
    let(:player1) { Player.new('Dio', 'X') }
    let(:player2) { Player.new('Johnathan', 'O') }

    subject(:game) { described_class.new(board, player1, player2) }

    context 'when the current player has won' do
      before do
        4.times { board.drop_disc(0, 'X') }
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when the board is full' do
      before do
        7.times do |col|
          6.times { board.drop_disc(col, 'X') }
        end
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when there is no win and the board is not full' do
      it 'returns false' do
        expect(game.game_over?).to be false
      end
    end
  end

  describe '#game_tied?' do
    let(:board)   { Board.new }
    let(:player1) { Player.new('Dio', 'X') }
    let(:player2) { Player.new('Johnathan', 'O') }

    subject(:game) { described_class.new(board, player1, player2) }

    context 'when the board is full and no player has won' do
      before do
        allow(board).to receive(:full?).and_return(true)
        allow(board).to receive(:win_combination?).and_return(false)
      end

      it 'returns true' do
        expect(game.game_tied?).to be true
      end
    end

    context 'when the board is full but the current player has won' do
      before do
        4.times { board.drop_disc(0, 'X') }
        3.times { board.drop_disc(1, 'O') }
      end

      it 'returns false' do
        expect(game.game_tied?).to be false
      end
    end

    context 'when the board is not full' do
      it 'returns false' do
        expect(game.game_tied?).to be false
      end
    end
  end

end