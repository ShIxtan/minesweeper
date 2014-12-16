class Tile
attr_accessor :bomb, :flag, :show

  def initialize
    @bomb = bomb?
    @flag = false
    @show = false
  end

  def bomb?
    if rand(10) == 1
      true
    else
      false
    end
  end

  def to_s
  bomb ? "X" : "*" 
  end
end

class Board

  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9)}
    board.each.with_index do|row, column|
      row.each_index do |i|
      board[column][i] = Tile.new
    end
  end
end

  def render
    board.each {|row| puts row.join(" ")}
  end
end

a = Board.new

a.render
