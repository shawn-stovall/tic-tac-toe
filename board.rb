# Class to contain the state of the Tic Tac Toe board
class Board
  attr_reader :board
  
  # Initialize @board instance variable to all nils. 1 = O, nil = Empty, -1 = X.
  def initialize
    @board = [[nil,nil,nil],
              [nil,nil,nil],
              [nil,nil,nil]]
  end

  def place_O(x, y)
    place(x, y, @@O)
    @board
  end

  def place_X(x, y)
    place(x, y, @@X)
    @board
  end

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

  @@O       = 1
  @@X       = -1
  @@check_O = Proc.new { |elem| elem == @@O }
  @@check_X = Proc.new { |elem| elem == @@X }

  private
  def horiz_win?
    @board.each do |line|
      win_O = line.all?(&@@check_O)
      win_X = line.all?(&@@check_X)

      return @@O if win_O
      return @@X if win_X
    end

    return nil
  end

  def vert_win?
    for i in 0..2
      arr = @board.map { |e| e[i] }
      
      win_O = arr.all?(&@@check_O)
      win_X = arr.all?(&@@check_X)

      return @@O if win_O
      return @@X if win_X
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

    return @@O if lwin_O || rwin_O
    return @@X if lwin_X || rwin_X
    return nil
  end

  def place(x,y,val)
    begin
      if (x < 0 || x > 2) || (y < 0 || y > 2)
        raise RangeError, "Error: Values must be 0 through 2."
      end
      @board[y][x] = val
    rescue RangeError => e
      puts e.message
      print "Please enter x: "
      x = gets.chomp.to_i
      print "Please enter y: "
      y = gets.chomp.to_i
      retry
    end
  end    
end
