require_relative 'player'
require_relative 'board'
require_relative 'game'

dio = Player.new('Dio', 'X')
jojo = Player.new('Jojo', 'O')

board = Board.new

game = Game.new(board, dio, jojo)

game.game
