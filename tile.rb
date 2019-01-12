class Tile

  attr_accessor :value, :bomb, :flag

  def initialize(value)
    @value = value
    @bomb = false
    @flagged = false
    @shown = false
  end

  def create_cells
    @shown == false ? value = CELL : value == "_"
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