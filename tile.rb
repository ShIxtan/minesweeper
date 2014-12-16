require 'colorize'

class Tile
  attr_accessor :bomb, :flagged, :show, :board, :position

  def initialize(board, position)
    @board = board
    @position = position
    @bomb = bomb?
    @flagged = false
    @show = false
  end

  def bomb?
    if rand(10) == 1
      true
    else
      false
    end
  end

  def reveal
    @show = true
    unless bombs?
      neighbors.each do |neighbor|
        unless neighbor.is_bomb? || neighbor.revealed? || neighbor.flagged? || bombs?
          neighbor.reveal
        end
      end
    end
  end

  def neighbors
    neighbors = []
    x, y = position

    [1,0,-1].each do |i|
      [1,0,-1].each do |j|
        next if i == 0 && j == 0
        next unless [x+i, y+j].all? {|coord| (0..8).include?(coord)}
        neighbors << board[x + i][y + j]
      end
    end

    neighbors
  end

  def to_s
    if self == board.pos
      "#"
    else
      if revealed?
        if is_bomb?
          "\u2735".colorize(:red)
        elsif bombs?
          "#{num_bombs}"
        else
          " "
        end
      else
        if flagged?
          "\u16a9"
        else
          "\u2395"
        end
      end
    end
  end

  def inspect
    position
  end

  def flag
    self.flagged = !flagged
  end

  def bombs?
    num_bombs > 0
  end

  def num_bombs
    bombs = 0
    neighbors.each do |neighbor|
      bombs += 1 if neighbor.is_bomb?
    end

    bombs
  end

  def is_bomb?
    bomb
  end

  def revealed?
    show
  end

  def flagged?
    flagged
  end

end
