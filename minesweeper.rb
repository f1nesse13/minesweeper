require_relative 'board'
require_relative 'tile'
require 'yaml'
class Minesweeper
  
  LAYOUTS = {
    small: { grid_size: 9, num_bombs: 10 },
    medium: { grid_size: 16, num_bombs: 40 },
    large: { grid_size: 32, num_bombs: 160 } # whoa.
  }.freeze

  def initialize(size)
    layout = LAYOUTS[size]
    @board = Board.new(layout[:grid_size], layout[:num_bombs])
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

  def save?
    puts "To save your game enter 's' or hit enter to continue"
    input = gets.chomp.downcase
    input == "s" ? save : nil
  end

  def take_turn
    until @board.win? || @board.lost?
      @board.render
      save?
      pos = get_pos
      input = get_action
      get_move(input, pos)

      if @board.win?
        @board.reveal
        @board.render
        puts "You win!!"
      elsif @board.lost?
        @board.reveal
        @board.render
        puts "BOOM!"
        puts "Sorry you lost"
      end
    end
  end

  def save
    puts "Enter the filename to save as"
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end

end
if $PROGRAM_NAME == __FILE__
  puts "enter name"
  name = gets.chomp
  if ARGV.empty?
    minesweeper = Minesweeper.new(:medium).take_turn
  elsif ARGV.length == 1
    YAML.load(ARGV.first).take_turn
  end
end