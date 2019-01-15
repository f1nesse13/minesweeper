require_relative 'tile'

class Board
  CELL = '⬜'
  FLAG = '⚑'
  MINE = "X"

  attr_reader :grid

    def initialize(grid_size, num_bombs)
    @grid_size, @num_bombs = grid_size, num_bombs
    generate_board

  end

  def generate_board
    @grid = Array.new(@grid_size) do |row|
      Array.new(@grid_size) { |col| Tile.new(CELL, self, [row, col]) }
    end

    place_bombs
  end

  def render
    rtn_array = []
    puts "  #{(0..8).to_a.join(' ')} "
    @grid.map.with_index do |row, i|
      rtn_array << []
      row.map do |x|
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

  def lost?
    @grid.flatten.any? { |tile| tile.bomb && tile.shown }
  end

  def win?
    @grid.flatten.all? { |tile| tile.shown != tile.bomb }
  end

  def place_bombs 
    bomb_counter = 0
    while bomb_counter <= @num_bombs
      row = rand(9).floor
      col = rand(9).floor
      random_cell = @grid[row][col]
      if random_cell.bomb == false
        random_cell.bomb = true
        bomb_counter += 1
      end
    end
    nil
  end

end
