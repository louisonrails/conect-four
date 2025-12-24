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

  def turn
    loop do
      print "#{@current_player.name}, it's your turn! Enter the column: "
      column = gets.to_i - 1

      unless @board.column_full?(column)
        @board.drop_disc(column, @current_player.symbol)
        break
      else
        puts 'Invalid Move! Try Again'
      end  
    end  
  end

  def game
    loop do
      @board.display
      turn
      break if game_over?
      turn_player
    end

    if @board.win_combination?(@current_player.symbol)
      puts "#{@current_player.name} wins!"
    else
      puts "It's a tie"
    end
  end
end