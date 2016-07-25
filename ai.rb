require_relative 'game'

class Ai

  PROB_WEIGHT = 5000
  OPEN_HIGH_MIN = 20
  OPEN_HIGH_MAX = 30
  OPEN_MED_MIN = 15
  OPEN_MED_MAX = 25
  OPEN_LOW_MIN = 10
  OPEN_LOW_MAX = 20
  RANDOMNESS = 10
  OPENING = [
    {coord: [7,3], weight: rand(OPEN_LOW_MIN..OPEN_LOW_MAX)},
    {coord: [6,2], weight: rand(OPEN_LOW_MIN..OPEN_LOW_MAX)},
    {coord: [2,6], weight: rand(OPEN_LOW_MIN..OPEN_LOW_MAX)},
    {coord: [6,6], weight: rand(OPEN_LOW_MIN..OPEN_LOW_MAX)},
    {coord: [3,3], weight: rand(OPEN_LOW_MIN..OPEN_LOW_MAX)},
    {coord: [5,5], weight: rand(OPEN_LOW_MIN..OPEN_LOW_MAX)},
    {coord: [4,4], weight: rand(OPEN_LOW_MIN..OPEN_LOW_MAX)},
    {coord: [0,8], weight: rand(OPEN_MED_MIN..OPEN_MED_MAX)},
    {coord: [1,9], weight: rand(OPEN_HIGH_MIN..OPEN_HIGH_MAX)},
    {coord: [8,0], weight: rand(OPEN_MED_MIN..OPEN_MED_MAX)},
    {coord: [9,1], weight: rand(OPEN_HIGH_MIN..OPEN_HIGH_MAX)},
    {coord: [9,9], weight: rand(OPEN_HIGH_MIN..OPEN_HIGH_MAX)},
    {coord: [0,0], weight: rand(OPEN_HIGH_MIN..OPEN_HIGH_MAX)}
  ]
  attr_reader :board, :ships


  def initialize(board)
    @prob_grid = Array.new(10){Array.new(10){0}}
    @board = board
    @ships = board.ships
  end  

  def shoot
    update_prob_grid
    OPENING.each do |cell|
      if @prob_grid[cell[:coord][0]][cell[:coord][1]] != 0
      @prob_grid[cell[:coord][0]][cell[:coord][1]] += cell[:weight] 
      end
    end
    max_prob_cell = []
    max_prob = 0
    @prob_grid.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        if col > max_prob 
          max_prob = col
          max_prob_cell = [[row_index, col_index]]
        elsif col == max_prob
          max_prob_cell << [row_index, col_index]
        end
      end
    end
    max_prob_coords = rand(1..100) <= RANDOMNESS ? max_prob_cell[rand(0...max_prob_cell.length)] : max_prob_cell[0] 
  end

  def update_prob_grid
    # binding.pry

    reset_prob_grid
    board.ships_left.each do |ship|
      (0..Game::GRID_SIZE - 1).each do |row|
        (0..Game::GRID_SIZE - 1).each do |col|
          [true, false].each do |vertical|
            update_prob_cell(ship, vertical, row, col)
          end
        end
      end
    end
  end

  def update_prob_cell(ship, vertical, row, col)
      if board.isLegal?(ship, vertical, row , col)
        x, y = row, col
        if board.passThroughHitCell?(ship, vertical, row, col)
          ship.size.times do
            @prob_grid[x][y] += PROB_WEIGHT * board.numHitCellCovered(ship, vertical, row, col)
            vertical ? x += 1 : y +=1
          end
        else
          ship.size.times do 
            @prob_grid[x][y] += 1
            vertical ? x +=1 : y += 1
          end
        end
      end
      @prob_grid[row][col] = 0 if board.has_been_hit?(row, col)
  end

  def reset_prob_grid
    @prob_grid = Array.new(10){Array.new(10){0}}
  end
end