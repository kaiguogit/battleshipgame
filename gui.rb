class Gui

  def get_input
    print ">"
    gets.chomp.downcase
  end

  def enter_player_name(player)
      puts "Please enter player #{player + 1}'s name"
      get_input.capitalize
  end


  def print_player_board(players, turn, visible)
  puts "Player #{turn + 1}'s board:"
  puts "__A_B_C_D_E_F_G_H_I_J_"
  players[turn].board.board.each_with_index do |row, index|
    print "#{index}|"
    row.each do |col|
      if col[:shipid] == 0
        print "#{col[:hit] ? "H".green : "_"}|"
      else 
        if visible
          print "#{col[:hit] ? "X".red : "O".yellow}|"
        else
          print "#{col[:hit] ? "X".red : "_"}|"
        end
      end
    end
    puts "" 
  end
  puts "
  "
  end

  def show_turn(turn, players)
    puts "It's now player #{turn + 1}, #{players[turn].name}'s turn."
    puts ""
  end

  def get_hit_coord(player)
    begin 
      puts "Player #{player + 1} Please enter the row number you want to hit, valid iput is [0-9][A-J], case insensitive"
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

  # def hit_col(player)
  #   begin 
  #     puts "Player #{player + 1} Please enter the row number you want to hit, valid iput is A-J"
  #     col = get_input    
  #     verify = col.match(/^[a-j]$/)
  #     puts "Invalid input.".red if verify ==nil
  #   end while verify == nil
  #   alphabet = ("a".."j").to_a
  #   alphabet.index(col)
  # end

  def verify(input)
    if input > 9 || input < 0 
      puts "Invliad input."
      return false
    end
    true
  end

  def show_winner(player, name)
    puts "Congratulations, player #{player + 1}, #{name} won."
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