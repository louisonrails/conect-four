class Game
  attr_reader :board, :player1, :player2, :current_player, :winner

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @winner = nil
  end

  def turn_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def game_over?
    @board.win_combination?(@current_player.symbol) || @board.full?
  end

  def game_tied?
    @board.full? && !@board.win_combination?(@current_player.symbol)
  end
end