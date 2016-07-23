class Game
  
  def initialize()
    @players = [Player.new, Player.new]
    @turn = 0
    @gui = Gui.new
  end

  def toggle_turn
    @turn +=1 
    @turn = 0 if @turn == 200
  end

  def turn
    @turn % 2
  end

  def turn_opposite
    (@turn + 1) % 2 
  end

  def current_player
    @players[turn]
  end

  def create_ship (number,size)
    ships = []
    number.times do
      ships << Ship.new(size)
    end
    ships
  end

  def get_player_name
    2.times do 
      current_player.name = @gui.enter_player_name(turn)
      toggle_turn
    end
  end

  def reset
    [0,1].each do |player|
      ships = create_ship(4,1) + create_ship(3,2) + create_ship(2,3) + create_ship(1,4)
      @players[player].place_ships_rand(ships)
    end
  end

  def create_ship (number,size)
  ships = []
  number.times do
    ships << Ship.new(size)
  end
  ships
  end

  def start
    get_player_name
    reset
    while true
      @gui.show_turn(turn, @players)
      @players[turn_opposite].board.hit(@gui.hit_row(turn),@gui.hit_col(turn))
      @gui.print_player_board(@players, turn, true)
      @gui.print_player_board(@players, turn_opposite, false)
      toggle_turn
    end 
  end 

end