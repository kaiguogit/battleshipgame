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

  def create_ship
    ships = []
    Ship::AVAILABLE_SHIPS.keys.each do |type|
      ships << Ship.new(type)
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
    @players[1].set_type_to_computer
    create_ship
    [0,1].each do |player|
      @players[player].ships = create_ship
      @players[player].place_ships_rand
    end
  end

  def hit_manual
    print_boards
    while true
      row, col = @gui.get_hit_coord(turn)
      break if !@players[turn_opposite].board.has_been_hit?(row,col)
      @gui.spot_has_been_hit 
    end
    @players[turn_opposite].board.hit(row,col)
    @players[turn_opposite].board.has_ship?(row,col) ? @gui.you_hit_a_ship : @gui.you_missed
  end

  def hit_auto
    while true
      row, col = current_player.hit_rand
      break if !@players[turn_opposite].board.has_been_hit?(row,col) 
    end
    @players[turn_opposite].board.hit(row,col)
  end

  def print_boards
    @gui.print_player_board(@players, turn, true)
    @gui.print_player_board(@players, turn_opposite, false)
    @gui.show_turn(turn, @players)
  end

  def ship_left?(player)
    @players[player].board.ship_left?
  end

  def start
    reset
    while true
      system("clear")
      if(current_player.type == :human)
        hit_manual
      else
        hit_auto
      end
      unless ship_left?(turn_opposite)
          @gui.show_winner(turn, current_player.name)
          break
      end
      toggle_turn
    end
  end 

  def restart?
    @gui.restart?
  end
end