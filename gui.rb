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
        print "#{col[:hit] ? "H" : "_"}|"
      else 
        if visible
          print "#{col[:hit] ? "x" : "0"}|"
        else
          print "#{col[:hit] ? "x" : "_"}|"
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

  def hit_row(player)
    begin 
      puts "Player #{player + 1} Please enter the row number you want to hit, valid iput is 0-9"
      row = get_input.to_i
    end while !verify(row)
    row
  end

  def hit_col(player)
    alphabet = ("a".."j").to_a
    begin 
      puts "Player #{player + 1} Please enter the row number you want to hit, valid iput is A-J"
      col = get_input    
      #binding.pry
      col = alphabet.index(col)
    end while !verify(col)
    col
  end

  def verify(input)
    if input > 9 || input < 0 
      puts "Invliad input."
      return false
    end
    true
  end

  def show_winner(player)
    puts "Congratulations, player #{player + 1} won."
  end
end