require_relative 'board'
class Tile
  CELL = '⬜'
  FLAG = '⚑'
  MINE = "X"
  DELTAS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
].freeze
  attr_accessor :value, :bomb, :flagged, :shown, :position, :adj_bomb

  def initialize(value, grid, position)
    @value = value
    @bomb, @flagged, @shown, @adj_bomb = false, false, false, false
    @position = position
    @grid = grid
  end

  def create_cells
    if @shown == true && @bomb == true
      @value = MINE
    end
    if @flagged == true
      @value = FLAG
    elsif @adj_bomb == true && @shown == true
      @value = value
    elsif @shown == true && @bomb == false
      @value = "_"
    end
  end

  def neighbors
    adjacent_coords = DELTAS.map do |(dx, dy)|
      [position[0] + dx, position[1] + dy]
    end.select do |row, col|
      [row, col].all? do |coord|
        coord.between?(0, @grid.grid_size - 1)
      end
    end

    adjacent_coords.map { |pos| @grid[pos] }
  end

  def adj_bomb_count
    neighbors.select { |tile| tile.bomb == true}.count
  end

  def explore
    return self.value if @flagged
    return self.value if @shown
    @shown = true
    if self.bomb == false && self.adj_bomb_count == 0
      self.neighbors.each { |tile| tile.explore }
    elsif self.adj_bomb_count != 0
      self.adj_bomb = true
      self.value = self.adj_bomb_count.to_s
    end

    self
  end

  def inspect
    { position: position,
      bomb: bomb,
      flagged: flagged,
      value: value }.inspect
  end

end
