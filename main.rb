require './board'
require_relative 'ship'
require 'pry-byebug'
require './player'

def create_ship (number,size)
  ships = []
  number.times do
    ships << Ship.new(size)
  end
  ships
end



player1 = Player.new
player2 = Player.new

player1_ships = create_ship(4,1) + create_ship(3,2) + create_ship(2,3) + create_ship(1,4)
player2_ships = create_ship(4,1) + create_ship(3,2) + create_ship(2,3) + create_ship(1,4)

player1.place_ships_rand(player1_ships)
player2.place_ships_rand(player2_ships)

puts "Player1's board"
player1.print_board

puts "Player2's board"
player2.print_board