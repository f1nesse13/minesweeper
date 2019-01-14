require_relative 'tile'
class Board
  CELL = '⬜'
  FLAG = '⚑'
  MINE = "X"

  attr_reader :grid
  
  def self.empty_grid
    Array.new(9) do
      Array.new(9) { Tile.new(CELL) }
    end
  end

  def initialize(grid=Board.empty_grid)
    @grid = grid
  end

  def render
    rtn_array = []
    puts "  #{(0..8).to_a.join(' ')} "
    @grid.each_with_index do |row, i|
      rtn_array << []
      row.each do |x|
        x.create_cells
        rtn_array[i] << x.value
      end
    end
    rtn_array.each_with_index { |line, i| puts "#{i} #{line.join(" ")}" }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y].value = val
  end

  def adjacent_squares(pos)
    return nil if pos == nil
    row, col = pos
    left_of_pos = @grid[row][col-1]
    right_of_pos = @grid[row][col+1]
    above_pos = @grid[row-1][col]
    below_pos = @grid[row+1][col]
    if left_of_pos.bomb != true && right_of_pos.bomb != true && above_pos.bomb != true && below_pos.bomb != true
      @grid[row][col].shown = true
      adjacent_squares(left_of_pos)
      adjacent_squares(right_of_pos)
      adjacent_squares(below_pos)
      adjacent_squares(above_pos)
    end
  end

end
