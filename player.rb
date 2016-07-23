class Player

  attr_reader :board

  attr_accessor :name

  def initialize
    @board = Board.new
    @name = ""
  end

  def place_ships_rand (ships)
    ships.each do |ship|
      100.times do
        row = (0...10).to_a.sample
        col = (0...10).to_a.sample
        verticle = [true, false].sample
        break if @board.place_ship?(ship,verticle,row,col)
      end
    end 
  end
end