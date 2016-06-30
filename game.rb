require "./board"
require "./player"

def play(p1, p2)
  game = Board.new
  winner = nil
  player1 = p1
  player2 = p2

  player1.assign("O")
  player2.assign("X")

  until (winner = game.win?) || game.full?
    render_board(game)

    game.place_O(player1.get_assign)
    game.place_X(player2.get_assign)
  end

  if winner == 1
    player1.win
  elsif winner == -1
    player2.win
  else
    puts "It's a draw!  Everyone loses!"
  end
end
