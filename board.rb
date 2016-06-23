# Class to contain the state of the Tic Tac Toe board
class Board
  attr_reader :board
  
  # Initialize @board instance variable to all nils. 1 = O, nil = Empty, -1 = X.
  def initialize
    @board = [[nil,nil,nil],
              [nil,nil,nil],
              [nil,nil,nil]]
  end

  def play
    until win?
      puts "O:  Please enter x position: "
      x = gets.chomp.to_i

      puts "O:  Please enter y position: "
      y = gets.chomp.to_i

      @board[x][y] = 1
      print @board[0].to_s + "\n"
      print @board[1].to_s + "\n"
      print @board[2].to_s + "\n"
    end
  end

  private
  @@check_O = Proc.new { |elem| elem == 1  }
  @@check_X = Proc.new { |elem| elem == -1 }
  # Check if there is a win.
  #
  #   game = Board.new
  #   # Game is played...
  #   game.win?  # 1   = O wins.
  #   game.win?  # nil = No win on board.
  #   game.win?  # -1  = X wins.
  def win?
    horiz_win? || vert_win? || diag_win?
  end

  def horiz_win?
    @board.each do |line|
      win_O = line.all?(&@@check_O)
      win_X = line.all?(&@@check_X)

      return  1 if win_O
      return -1 if win_X
    end

    return nil
  end

  def vert_win?
    for i in 0..2
      arr = @board.map { |e| e[i] }
      
      win_O = arr.all?(&@@check_O)
      win_X = arr.all?(&@@check_X)

      return  1 if win_O
      return -1 if win_X
    end

    return nil
  end

  def diag_win?
    x = -1
    left  = @board.map { |elem| elem[x += 1] }
    
    x = 3
    right = @board.map { |elem| elem[x -= 1] }

    lwin_O = left.all?(&@@check_O)
    lwin_X = left.all?(&@@check_X)

    rwin_O = right.all?(&@@check_O)
    rwin_X = right.all?(&@@check_X)

    return  1 if lwin_O || rwin_O
    return -1 if lwin_X || lwin_X
    return nil
  end
end
