require './board'
require_relative 'ship'
require 'pry-byebug'
require_relative 'gui'
require_relative 'player'
require_relative 'game'
require 'colorize'

game = Game.new

system("clear")
game.get_player_name
begin
  game.start
end while game.restart?
puts "Bye bye"