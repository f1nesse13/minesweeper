require_relative 'board'
require_relative 'tile'

class Minesweeper
  
  def initialize
    @board = Board.new
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

  def game_over?
    @board.grid.each do |row|
      return row.all? { |tile| tile.shown == true || tile.flagged == true || tile.bomb == true }
    end
  end

  def take_turn
    until game_over?
      @board.render
      pos = get_pos
      input = get_action
      input.downcase == "f" ? @board.grid[pos[0]][pos[1]].flagged = !@board.grid[pos[0]][pos[1]].flagged : @board.grid[pos[0]][pos[1]].shown = true
    end
  end
  def check_bomb_number(input)
    input.between?(1, 51)
  end
  def customize_bombs
    input = nil
    until input && input.between?(1, 81)
      puts "By default 10 bombs are placed on the grid - if you would like to change the number of bombs enter the amount between 2-50"
      input = gets.chomp
      input = input.to_i
    end
    input
  end

def place_bombs(n=10)
  bomb_num = customize_bombs
  bomb_num == "" ? n : n = bomb_num 
  bomb_counter = 0
  p @board.grid[4][1].bomb
  while bomb_counter <= n
    row = Integer(rand(9).floor)
    col = Integer(rand(9).floor)
    random_cell = @board.grid[row][col]
    if random_cell.bomb == false
      random_cell.bomb = true
      bomb_counter += 1
    end
  end
  p @board.grid
  p @board

end

end

if $PROGRAM_NAME == __FILE__
  minesweeper = Minesweeper.new
  minesweeper.place_bombs
  minesweeper.take_turn
end