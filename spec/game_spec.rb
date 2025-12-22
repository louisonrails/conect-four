require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

RSpec.describe Game do
  describe '#initialize' do
    board = Board.new
    player1 = Player.new('Dio', 'X')
    player2 = Player.new('Johnathan', 'O')

    game = described_class.new(board, player1, player2)
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
end