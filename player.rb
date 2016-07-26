class Player

  PERMITTED_TYPE = [:human, :computer]
  attr_reader :board, :type, :ships

  attr_accessor :name

  #
  def initialize(type)
    @board = Board.new([])
    @name = ""
    @type = type
    @ships = []
  end

  def ships=(ships)
    @board.ships = ships
    @ships = ships
  end

  def place_ships_rand
    ships.each do |ship|
      100.times do
        row, col = hit_rand
        verticle = [true, false].sample
        break if @board.place_ship(ship,verticle,row,col)
      end
    end 
  end

  def hit_rand
    row = (0...Game::GRID_SIZE).to_a.sample
    col = (0...Game::GRID_SIZE).to_a.sample
  [row,col]
  end

  def isHuman?
    type == :human
  end

end