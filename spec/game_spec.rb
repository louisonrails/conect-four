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

  describe '#turn_player' do
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

  describe '#turn' do
    let(:board)   { instance_double(Board) }
    let(:player1) { Player.new('Dio', 'X') }
    let(:player2) { Player.new('Johnathan', 'O') }

    subject(:game) { described_class.new(board, player1, player2) }

    before do
      # Silence output
      allow(game).to receive(:print)
      allow(game).to receive(:puts)
    end

    context 'when the move is valid' do
      before do
        allow(game).to receive(:gets).and_return("1\n")
        allow(board).to receive(:column_full?).with(1).and_return(false)
        allow(board).to receive(:drop_disc)
      end

      it 'drops a disc in the chosen column' do
        expect(board).to receive(:drop_disc).with(1, 'X')
        game.turn
      end

      it 'does not print an error message' do
        expect(game).not_to receive(:puts).with('Invalid Move! Try Again')
        game.turn
      end
    end

    context 'when the column is full' do
      before do
        allow(game).to receive(:gets).and_return("1\n", "1\n")
        allow(board).to receive(:column_full?).with(1).and_return(true, false)
        allow(board).to receive(:drop_disc)
      end

      it 'prints an invalid move message' do
        expect(game).to receive(:puts).with('Invalid Move! Try Again')
        game.turn
      end

      it 'eventually drops a disc after retry' do
        expect(board).to receive(:drop_disc).with(1, 'X')
        game.turn
      end
    end
  end

  describe '#game' do
    let(:board)   { instance_double(Board) }
    let(:player1) { Player.new('Dio', 'X') }
    let(:player2) { Player.new('Johnathan', 'O') }

    subject(:game) { described_class.new(board, player1, player2) }

    before do
      allow(game).to receive(:turn)
      allow(game).to receive(:turn_player)
      allow(game).to receive(:puts)
    end

    context 'when the current player wins' do
      before do
        # First loop iteration runs, then game ends
        allow(game).to receive(:game_over?).and_return(false, true)
        allow(board).to receive(:win_combination?)
          .with(player1.symbol)
          .and_return(true)
      end

      it 'announces the winner' do
        expect(game).to receive(:puts).with('Dio wins!')
        game.game
      end
    end

    context 'when the game ends in a tie' do
      before do
        allow(game).to receive(:turn)
        allow(game).to receive(:turn_player)
        allow(game).to receive(:game_over?).and_return(true)
        allow(board).to receive(:win_combination?)
          .with(player1.symbol)
          .and_return(false)
        allow(game).to receive(:puts)
      end

      it 'announces a tie' do
        expect(game).to receive(:puts).with("It's a tie")
        game.game
      end
    end

    it 'calls turn at least once' do
      allow(game).to receive(:game_over?).and_return(true)
      allow(board).to receive(:win_combination?).and_return(false)

      expect(game).to receive(:turn)
      game.game
    end
  end

end