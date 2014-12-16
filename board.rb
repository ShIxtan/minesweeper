require_relative 'tile'
require 'colorize'
require 'io/console'

class Board

  attr_accessor :board, :pos

  def initialize(size = 9)
    @board = Array.new(size) { Array.new(size)}
    board.each.with_index do |row, i|
      row.each_index do |j|
        board[i][j] = Tile.new(self, [i, j])
      end
    end
    @pos = self.board[5][5]
  end

  def render
    system('clear')
    print "  "
    (0..8).each {|num| print " #{num}"}
    puts
    board.each_with_index {|row, index| puts "#{index}  " + row.join(" ")}
  end

  def [](x,y)
    board[x][y]
  end

  def reveal_all
    board.each.with_index do |row, i|
      row.each_index do |j|
        board[i][j].reveal
      end
    end
  end

  def won?
    board.each_with_index do |row, i|
      row.each_index do |j|
        tile = board[i][j]
        if tile.is_bomb? && !tile.flagged?
          return false
        elsif !tile.is_bomb? && !tile.revealed?
          return false
        end
      end
    end
    return true
  end
end
