class Gui

  def get_input
    print ">"
    gets.chomp.downcase
  end

  def enter_player_name(player)
      puts "Please enter player #{player + 1}'s name"
      get_input.capitalize
  end

# TODO change this method to print two board in one row hotizotally  
  def print_player_board(players, turn, visible, end_of_game)
    turn_opposite = (turn == 1 ? 0 : 1)
    puts "Player #{turn + 1}, #{players[turn].name}'s board:     Player #{turn_opposite + 1}, #{players[turn_opposite].name}'s board:"
    puts "#{"  A B C D E F G H I J ".black.on_white.bold.underline}     #{"  A B C D E F G H I J ".black.on_white.bold.underline}"
    board1 = players[turn].board
    board2 = players[turn_opposite].board
    (0..9).each do |row_index|
      print "#{row_index}|".black.on_white
      print_player_board_row(board1, row_index, visible || end_of_game) 
      print "     "
      print "#{row_index}|".black.on_white      
      print_player_board_row(board2, row_index, !visible || end_of_game) 
      puts "" 
    end
  end

  def print_player_board_row(board, row_index, visible)
    board.board[row_index].each_with_index do |col, col_index|
      if col[:shipid] == 0
        print "#{col[:hit] ? " ".on_green : "_".black.on_white}#{"|".black.on_white}"
      else 
        if col[:hit]
          print "#{board.isSpotSunk?(row_index, col_index) ? " ".on_black : "X".black.on_red.bold.underline }#{"|".black.on_white}"
          #print "#{col[:hit] ? (board.isSpotSunk?(row_index, col_index) ? "X".grey : "X".red ) : "O".yellow}|"
        else
          print "#{visible ? "_".black.on_yellow : "_".black.on_white }#{"|".black.on_white}"
          # print "#{col[:hit] ? (board.isSpotSunk?(row_index, col_index) ? "X".grey : "X".red )  : "_"}|"
        end
      end
    end
  end

  def print_ship_left(players, turn)
    puts "Player #{turn+1}, #{players[turn].name}'s remaining ship: "
    puts "Name              size"
    players[turn].ships.each do |ship|
      ship_name = "#{ship.type.to_s.gsub(/_/, " ").capitalize}"
      ship_name += " " * (20 - ship_name.size) 
      puts "#{ship_name}#{ship.size}" unless ship.isSunk?
    end
  end

  def show_turn(turn, players)
    puts "It's now player #{turn + 1}, #{players[turn].name}'s turn."
  end

  def get_hit_coord(players, turn)
    begin 
      puts "Player #{turn + 1} #{players[turn].name}, please enter the row number you want to hit, valid iput is [0-9][A-J], case insensitive"
      coods = get_input
      matches  = coods.match(/^([0-9])([a-jA-J])$/)
      #binding.pry
      puts "Invalid input.".red if matches == nil
    end while matches == nil
    alphabet = ("a".."j").to_a
    col = alphabet.index(matches.captures[1])
    row = matches.captures[0].to_i
    [row, col]
  end

  def verify(input)
    if input > 9 || input < 0 
      puts "Invliad input."
      return false
    end
    true
  end

  def show_winner(players, turn)
    if turn == 0
      puts 
      puts "Congratulations, #{players[turn].name}, you won.".red
    else
      puts ""
      puts "Sorry, AI won.".red
    end
  end

  def spot_has_been_hit
    puts "This spot has been hit. Please choose another one."
  end

  def you_hit_a_ship
    puts "You just hit a ship".green
  end

  def you_missed
    puts "You missed".red
  end

  def you_sank_a_ship(shiptype)
    puts "You just sank a #{shiptype.gsub(/_/, " ").capitalize}.".green    
  end

  def restart?
    puts "Do you want to restart the game? Enter Yes or No"
    while true
      input = get_input.chomp.downcase
      if input == "no" 
        return false
      elsif input == "yes"
        return true
      else
        puts "invalid input, please enter Yes or No"
      end
    end
  end
end