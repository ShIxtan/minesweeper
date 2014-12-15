class Tile
attr_accessor :bomb, :flag, :show

  def initialize
    @bomb = false
    @flag = false
    @show = false
  end
end

class Board

  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9)}
    board.each.with_index do|row, column|
      row.each_index do |i|
      board[column][i] = "*"
    end
  end
end

  def render
    board.each {|row| puts row.join(" ")}
  end
end

a = Board.new

a.render
