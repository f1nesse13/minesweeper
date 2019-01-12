require_relative 'tile'
class Board
  CELL = '⬜'
  FLAG = '⚑'
  MINE = "X"
  def self.empty_grid
    Array.new(9) do
      Array.new(9) { Tile.new(CELL) }
    end
  end
  # def rows
  #   rtn_arr = []
  #   @grid.each_with_index do |row, i|
  #     row.each do |x|
  #       rtn_arr[i] << x.value
  #     end
  #   end
  #   rtn_arr
  # end

  def initialize(grid=Board.empty_grid)
    @grid = grid
  end

  def render
    rtn_array = []
    puts "  #{(0..8).to_a.join(' ')}"
    @grid.each_with_index do |row, i|
      rtn_array << []
      row.each do |x|
        rtn_array[i] << x.value
      end
    end
    rtn_array.each_with_index { |line, i| puts "#{i} #{line.join(" ")}" }
  end

  def bomb_grid(n)
    bomb_counter = 0
    while bomb_counter <= n
      random_cell = @grid[rand(10)][rand(10)]
      if random_cell.bomb == false
        random_cell.bomb = true
        bomb_counter += 1
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y].value = val
  end

  def test
    @grid[0][2].value = 2
    @grid[4][4].value = 4
  end
end

a = Board.new
a.render
# a.bomb_grid
a.test
a.render