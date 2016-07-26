class Board

  attr_reader :board
  attr_accessor :ships

  def initialize(ships)
    @board = Array.new(10){Array.new(10)}
    reset
    @ships = ships
  end

  def reset
    @board.map! do |row|
      row.map! do |col|
        col = {shipid: 0, hit: false}
      end
    end
  end

  def placable?(ship,vertical, row, col)
    return false unless isLegal?(ship, vertical, row, col)
    ship.size.times do 
      if has_ship?(row, col)
        return false
      else
        vertical ? row += 1 : col += 1
      end 
    end
    true
  end
  
  def isLegal?(ship, vertical, row, col)
    return false if vertical && row + ship.size > Game::GRID_SIZE
    return false if !vertical && col + ship.size > Game::GRID_SIZE
    ship.size.times do 
      if isSpotMiss?(row,col) || isSpotSunk?(row, col)
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
  def place_ship(ship, vertical, row, col)
      return false unless placable?(ship, vertical,row,col)
      ship.size.times do
        spot(row,col)[:shipid] = ship.id
        vertical ? row += 1 : col += 1
      end
      true
  end

  def isSpotMiss?(row, col)
    has_been_hit?(row, col) && !has_ship?(row, col)
  end

  def passThroughHitCell?(ship, vertical, row, col)
    ship.size.times do 
      return true if isSpotDamagedShip?(row, col)
      vertical ? row +=1 : col +=1
    end
    false
  end

  def numHitCellCovered(ship, vertical, row, col)
    count = 0
    ship.size.times do
      count +=1 if isSpotDamagedShip?(row, col)
      vertical ? row +=1 : col +=1
    end
    count
  end

  def ships_left
    @ships.select {|ship| !ship.isSunk?}
  end

  def isSpotSunk?(row, col)
    update_ship_status
    ship = get_ship(row, col)
    ship == nil ? false : get_ship(row, col).isSunk?
  end

  def isSpotDamagedShip?(row, col) 
    !isSpotSunk?(row, col) && has_been_hit?(row, col) && has_ship?(row, col)
  end

  def get_ship(row, col)
    id = spot(row, col)[:shipid]
    return nil if id == 0
    ships.select{|ship| ship.id == id}[0]
  end

  def get_ship_coord(ship)
    raise ArgumentError, 'This ship is not on this board' unless ships.include?(ship)
    cells = []
    board.each do |row|
      row.each do |col|
        cells << [row, col] if col[:shipid] = ship.id
      end
    end
    cells
  end
  
  #return true if dirrection is vertical
  def get_ship_dirrection?(ship)
    cells = get_ship_coord
    vertical =  cells.size == 1 || (cells[0][1] == cells[1][1])
  end

  def has_been_hit?(row, col)
    spot(row,col)[:hit]
  end 

  def hit(row, col)
    spot(row,col)[:hit] = true
    update_ship_status
  end

  def has_ship?(row, col)
    spot(row,col)[:shipid] > 0 
  end
  
  #Return true if there is any ship has not been hit.
  #Return false bif no ship is placed or all have been hit.
  def ship_left?
    board.detect do |row|
      row.detect do |col|
        col[:shipid] != 0 && col[:hit] == false  
      end
    end
  end

  private

  def spot(row, col)
    board[row][col]  
  end

  def update_ship_status
    # binding.pry
    ships.each do |ship|
      ship.damage = board.inject(0) do |sum, row|
        sum + row.count do |col|
          col[:shipid] == ship.id && col[:hit] == true
        end
      end
    end 
  end
end