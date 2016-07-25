class Board

  attr_reader :board
  #on the board
  # 0 means empty
  # 1 means empty but has been hit by user
  # 2 means occupied
  # 3 means occuiped by has been hit by user
  def initialize
    @board = Array.new(10){Array.new(10)}
    @board.map! do |row|
      row.map! do |col|
        col = {shipid: 0, hit: false}
      end
    end
  end

  def placable?(ship,vertical, row, col)
    return false if vertical && row + ship.size - 1 >= 10
    return false if !vertical && col + ship.size - 1 >= 10 

    ship.size.times do 
      if has_ship?(row, col)
        return false
      else
        vertical ? row += 1 : col += 1
      end 
    end
    true
  end

  #place ship
  # if not placable, return false
  # if placable, place ship and return true
  def place_ship?(ship, vertical, row, col)
      return false unless placable?(ship, vertical,row,col)
      ship.size.times do
        spot(row,col)[:shipid] = ship.id
        vertical ? row += 1 : col += 1
      end
      true
  end

  def has_been_hit?(row, col)
    spot(row,col)[:hit]
  end 

  def hit(row, col)
    spot(row,col)[:hit] = true
  end

  def has_ship?(row, col)
    spot(row,col)[:shipid] > 0 
  end

  def spot(row, col)
    @board[row][col]  
  end
  
  #Return true if there is any ship has not been hit.
  #Return false bif no ship is placed or all have been hit.
  def ship_left?
    @board.detect do |row|
      row.detect do |col|
        col[:shipid] != 0 && col[:hit] == false  
      end
    end
  end
end