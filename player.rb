class Player
  attr_reader :wins, :symbol
  attr_accessor :win_slogan, :position_inq

  def initialize(name, symbol)
    @name = name
    assign(symbol)
    @wins = 0
    @win_slogan = "%{name} wins!"
    @position_inq = "Place %{symbol} at: "
  end

  def assign(symbol)
    begin
      symbol.upcase!
      raise "Error: symbol must be 'X' or 'O'" if symbol != "X" && symbol != "O"
    rescue Exception => e
      puts e
      print "Please enter 'X' or 'O': "
      symbol = gets.chomp
      retry
    end

    @symbol = symbol
  end

  def place
    begin
      print @position_inq % { name: @name, symbol: @symbol }
      placement = gets.chomp.split.map { |e| e.to_i }

      if placement.length != 2 || !placement.all? { |e| e <= 2 }
        raise "Error: Input must be two numbers less than 3 seperated by a space."
      end
    rescue Exception => e
      puts e
      retry
    end
    placement
  end    

  def win
    puts @win_slogan % { name: @name, symbol: @symbol }
    @wins += 1
  end
end
