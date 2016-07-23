require './board'
require_relative 'ship'
require 'pry-byebug'
require_relative 'gui'
require_relative 'player'
require_relative 'game'
require 'colorize'

game = Game.new

game.start
