require_relative 'board'
class Tile
  CELL = '⬜'
  FLAG = '⚑'
  MINE = "X"
  attr_accessor :value, :bomb, :flagged, :shown, :position

  def initialize(value, grid, position)
    @value = value
    @bomb, @flagged, @shown = false, false, false
    @position = position
    @grid = grid
  end

  def create_cells
    if @shown == true && @bomb == true
      @value = MINE
    end
    if @flagged == true
      @value = FLAG
    elsif @shown == true && @flagged == false
      @value = " "
    else
      @value = CELL
    end
  end

  def neighbors
      pos1 = self.position[0]
      pos2 = self.position[1]
      arr = [
      @grid[[pos1, pos2-1]],
      @grid[[pos1, pos2+1]],
      @grid[[pos1-1, pos2]],
      @grid[[pos1+1, pos2]],
      @grid[[pos1-1, pos2-1]],
      @grid[[pos1-1, pos2+1]],
      @grid[[pos1+1, pos2-1]],
      @grid[[pos1+1, pos2+1]]
    ]
    arr = arr.select { |ele| ele.position[0].between?(0,8) && ele.position[1].between?(0,8) }
    arr
  end

  def adj_bomb_count
    neighbors.select { |tile| tile.bomb == true}.count
  end

  def explore
    return self.value if @flagged
    return self.value if @shown
    self.shown = true
    if !@bomb && self.adj_bomb_count == 0
      neighbors.each {|tile| tile.explore}
    else
      self.value = self.adj_bomb_count.to_s
    end

    self
  end
end
