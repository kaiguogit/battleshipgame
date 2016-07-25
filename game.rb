class Game
 
  GRID_SIZE = 10

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

  def create_ship
    ships = []
    Ship::AVAILABLE_SHIPS.keys.each do |type|
      ships << Ship.new(type)
    end
    ships
  end

  def get_player_name
      @players[0].name = @gui.enter_player_name(0)
      @players[1].name = "AI"
  end

  def reset
    @players.each {|player| player.board.reset}
    @players[1].set_type_to_computer
    [0,1].each do |player|
      @players[player].ships = create_ship
      @players[player].place_ships_rand
    end
    @robot = Ai.new(@players[0].board)
  end

  def hit_manual(previous_hit_coord)
    print_boards

    if previous_hit_coord
      row, col = previous_hit_coord
      if @players[turn_opposite].board.has_ship?(row,col)
        ship = @players[turn_opposite].board.get_ship(row,col)
        #binding.pry
        ship.isSunk? ? @gui.you_sank_a_ship(ship.type.to_s) : @gui.you_hit_a_ship
      else
        @gui.you_missed
      end
    end 

    while true
      row, col = @gui.get_hit_coord(@players, turn)
      break if !@players[turn_opposite].board.has_been_hit?(row,col)
      @gui.spot_has_been_hit 
    end
    @players[turn_opposite].board.hit(row,col)
    [row, col]
  end

  def hit_random
    while true
      row, col = current_player.hit_rand
      break if !@players[turn_opposite].board.has_been_hit?(row,col) 
    end
    @players[turn_opposite].board.hit(row,col)
  end

  def hit_auto
    # binding.pry
    row, col = @robot.shoot
    @players[turn_opposite].board.hit(row,col)
  end

  def print_boards
    system("clear")
    @gui.print_player_board(@players, turn, true, false)
    @gui.print_ship_left(@players, turn_opposite)
    #@gui.show_turn(turn, @players)
  end

  def ship_left?(player)
    @players[player].board.ship_left?
  end

  def start
    reset
    while true
      if(current_player.type == :human)
        previous_hit_coord = hit_manual(previous_hit_coord)
      else
        hit_auto
      end
      unless ship_left?(turn_opposite)
          system("clear")
          @gui.print_player_board(@players, 0, true, true)
          @gui.show_winner(@players, turn)
          break
      end
      toggle_turn
    end
  end 

  def restart?
    @gui.restart?
  end
end