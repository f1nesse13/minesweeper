class Tile

  def initialize(val)
    @val = val
    @bomb = val == "X" ? true : false
    @flagged = false
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