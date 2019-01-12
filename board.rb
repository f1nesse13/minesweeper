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
    rtn_array = []
    puts "  #{(0..8).to_a.join(' ')}"
    @grid.each_with_index do |row, i|
      rtn_array << []
      row.each do |x|
        x.create_cells
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
    @grid.each do |row|
      return row.all? { |tile| tile.shown == true || tile.flagged == true || tile.bomb == true }
    end
  end

  def take_turn
    until game_over?
      render
      pos = get_pos
      input = get_action
      input.downcase == "f" ? @grid[pos[0]][pos[1]].flagged = !@grid[pos[0]][pos[1]].flagged : @grid[pos[0]][pos[1]].shown = true
    end
  end

  def adjacent_squares(pos)
    return nil if pos == nil
    row, col = pos
    left_of_pos = @grid[row][col-1]
    right_of_pos = @grid[row][col+1]
    above_pos = @grid[row-1][col]
    below_pos = @grid[row+1][col]
    if left_of_pos.bomb != true && right_of_pos.bomb != true && above_pos.bomb != true && below_pos.bomb != true
      pos.shown = true
      adjacent_squares(left_of_pos)
      adjacent_squares(right_of_pos)
      adjacent_squares(below_pos)
      adjacent_squares(above_pos)
    end
  end

end
a = Board.new
a.take_turn