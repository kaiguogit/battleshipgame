class Ai
  def initialize(opponent_board, ships)
    @prob_grid = Array.new(10){Array.new(10){0}}
    @opponent_board = opponent_board
    @virtual_board = Board.new
  end  

  def update_prob

  end
end