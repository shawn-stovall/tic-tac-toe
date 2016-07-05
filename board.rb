# coding: utf-8
# Class to contain the state of the Tic Tac Toe board
class Board
  attr_reader :board
  
  # Initialize <code>@board</code> instance variable to all nils. 1 = O, nil = Empty, -1 = X.
  def initialize
    @board = [[nil,nil,nil],
              [nil,nil,nil],
              [nil,nil,nil]]
  end

  # Place an "O"(1) on the board at coordinates x and y.
  #
  #   @board = [[nil,nil,nil],
  #             [nil,nil,nil],
  #             [nil,nil,nil]]
  #
  #   game = Board.new
  #   game.place_O([0,1])
  #   @board = [[nil,nil,nil],
  #             [  1,nil,nil],
  #             [nil,nil,nil]]
  def place_O(coords)
    place(coords[0], coords[1], @@O)
    @board
  end

  # Place an "X"(-1) on the board at coordinates x and y.
  #
  #   @board = [[nil,nil,nil],
  #             [nil,nil,nil],
  #             [nil,nil,nil]]
  #
  #   game = Board.new
  #   game.place_X([0,1])
  #   @board = [[nil,nil,nil],
  #             [ -1,nil,nil],
  #             [nil,nil,nil]]
  def place_X(coords)
    place(coords[0], coords[1], @@X)
    @board
  end

  # Check if there is a win and return the winner.
  #
  #   game = Board.new
  #   # Game is played...
  #   game.win?  # 1   = O wins.
  #   game.win?  # nil = No win on board.
  #   game.win?  # -1  = X wins.
  def win?
    horiz_win? || vert_win? || diag_win?
  end

  # Check if board is full.
  def full?
    not_nil = Proc.new { |e| !e.nil? }

    row1_nil = @board[0].all?(&not_nil)
    row2_nil = @board[1].all?(&not_nil)
    row3_nil = @board[2].all?(&not_nil)

    if row1_nil && row2_nil && row3_nil
      true
    else
      false
    end
  end

  # Creates a String representation of the board given its current state.
  def render_board
    board = ""
    @board.each_with_index do |line, index|
      board << render_line(line) << "\n"
      board << "═══╬═══╬═══\n" if index < 2
    end
    board
  end
  
  private
  @@O       = 1
  @@X       = -1
  @@check_O = Proc.new { |elem| elem == @@O }
  @@check_X = Proc.new { |elem| elem == @@X }

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

  def place(x, y, val)
    begin
      raise RangeError, "Error: Values must be 0 through 2." if (x < 0 || x > 2) || (y < 0 || y > 2)
      raise ArgumentError, "Error: Position already occupied." if !board[y][x].nil?
      
      @board[y][x] = val
    rescue Exception => e
      puts e.message
      print "Please enter x: "
      x = gets.chomp.to_i
      print "Please enter y: "
      y = gets.chomp.to_i
      retry
    end
  end

  def render_line(line)
    " " + render_symbol(line[0]) + \
    " ║ " + render_symbol(line[1]) + \
    " ║ " + render_symbol(line[2])
  end

  def render_symbol(symbol)
    case symbol
    when nil
      " "
    when @@X
      "X"
    when @@O
      "O"
    end
  end
end
