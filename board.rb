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

  def initialize(grid=Board.empty_grid)
    @grid = grid
  end

  def render
    @grid.each do |row|
      row.each do |sq|
        sq
      end
    end
    @grid
  end

end

a = Board.new
p a.render