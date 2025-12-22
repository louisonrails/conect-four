class Game
  attr_reader :board, :player1, :player2, :current_player, :winner

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @winner = nil
  end
end