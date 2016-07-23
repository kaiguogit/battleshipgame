require_relative 'board'

def create_ship (number,size)
  ships = []
  number.times do
    ships << Ship.new(size)
  end
  ships
end

board = new Board
ships = create_ship(4,1) + create_ship(3,2) + create_ship(2,3) + create_ship(1,4)

while ships != []
  row = (0...10).sample
  col = (0...10).sample
  board.place_ship?(ships.first)
end