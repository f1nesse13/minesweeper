require_relative 'board'
require_relative 'tile'

class Minesweeper
  
  def initialize
    @board = Board.new(9, 10)
  end

  def parse_pos(pos)
    pos = pos.split(",").map(&:to_i)
  end

  def check_pos(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
        pos.all? { |val| Integer(val) }
  end

  def check_input(input)
    if input.downcase == "f" || input == ""
      return true
    else
      return false
    end
  end

  def get_pos
    pos = nil
    until pos && check_pos(pos)
      puts "Enter two values seperated by a comma to choose a row and column Ex. 2,5"
      pos = parse_pos(gets.chomp)
    end
    pos
  end

  def get_action
    input = nil
    until input && check_input(input)
      puts "If you want to flag/unflag this square enter F otherwise just hit enter to reveal the square"
      input = gets.chomp.downcase
      if check_input(input) == false
        puts "Invalid selection enter F to flag/unflag or hit enter to reveal"
      end
    end
    input
  end

  def get_move(action, pos)
    tile = @board.grid[pos[0]][pos[1]]
    case action
    when "f"
      tile.flagged = !tile.flagged
    when ""
      if tile.flagged == true
        puts "You cant reveal a flagged square - please unflag it first"
      elsif tile.shown == true
        puts "This square has already been revealed"
      else
        tile.explore
      end
    end
  end

  def take_turn
    until @board.win? || @board.lost?
      @board.render
      pos = get_pos
      input = get_action
      get_move(input, pos)

      if @board.win?
        puts "You win!!"
      elsif @board.lost?
        puts "BOOM!"
        puts "Sorry you lost"
      end
    end
  end

end
if $PROGRAM_NAME == __FILE__
  minesweeper = Minesweeper.new
  minesweeper.take_turn
end