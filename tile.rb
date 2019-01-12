class Tile
  CELL = '⬜'
  FLAG = '⚑'
  MINE = "X"
  attr_accessor :value, :bomb, :flagged, :shown

  def initialize(value)
    @value = value
    @bomb = false
    @flagged = false
    @shown = false
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

  def flagged?
    if @flagged
      "You cannot reveal flagged squares"
      @flagged
    end
    @flagged
  end
  def flag_square
    @flagged = !@flagged
  end

end