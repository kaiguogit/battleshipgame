def Board

  attr_accessor :board
  #on the board
  # 0 means empty
  # 1 means empty but has been hit by user
  # 2 means occupied
  # 3 means occuiped by has been hit by user
  def initialize()
    @board = Array.new(10) {Array.new(10, 
      {shipid: 0,
       hit: false
      })}
  end

  #place ship
  # if not placable, return false
  # if placable, place ship and return true
  def place_ship?(ship, vertical, row, col)
      ship.length.times do
        if has_ship?(row, col)
          return false 
        else
          spot(row,col)[:shipid] = ship.id
        end
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

  private

  def has_ship?(row, col)
    spot(row,col)[:shipid] != 0 
  end

  def spot(row, col)
    @board[row][col]  
  end

end