class Player

  attr_reader :board, :type

  attr_accessor :name, :ships

  #
  def initialize()
    @board = Board.new([])
    @name = ""
    @type = :human
    @ships = []
  end

  def ships=(ships)
    @board.ships = ships
    @ships = ships
  end

  def set_type_to_computer
    @type = :computer
  end

  def set_type_to_human
    @type = :human
  end

  def place_ships_rand
    ships.each do |ship|
      100.times do
        row = (0...10).to_a.sample
        col = (0...10).to_a.sample
        verticle = [true, false].sample
        break if @board.place_ship?(ship,verticle,row,col)
      end
    end 
  end

  def hit_rand
    row = (0...10).to_a.sample
    col = (0...10).to_a.sample
  [row,col]
  end

end