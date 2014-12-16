require 'yaml'
require_relative 'board'

class Minesweeper

  attr_accessor :board, :lost

  def initialize(filename = nil)
    @board = load(filename) if filename
    @board = Board.new() unless filename
  end

  def play
    timer = Time::now
    until board.won?
      take_turn
    end

    board.render
    puts "YOU ARE AWESOME"
    time = Time::now - timer
    puts "It took you #{time} seconds to complete the game!"
  end

  def save(filename)
    File.open("#{filename}.yml", "w") do |f|
      f.puts board.to_yaml
    end
  end

  def load(filename)
    YAML::load(File.read("#{filename}.yml"))
  end

  def lose
    self.lost = true
    puts "You lose."
    board.reveal_all
    board.render
    exit
  end

  def take_turn
    board.render
    choices = ['r','q','f','s']
    choice = nil
    until choices.include?(choice)
      puts "Reveal(r) Flag(f) "
      print "Save (s) Quit (q)? "
      choice = gets.chomp
    end

    lose if choice == "q"

    if choice == "s"
      print "filename?  "
      filename = gets.chomp
      save(filename)
      puts " saved to #{filename}.yml"
    else
      print "location? "
      pos = gets.chomp.split("").reject { |s| s == "," }.map(&:to_i)
      x, y = pos

      if choice == "r"
        board[x,y].reveal
        lose if board[x,y].is_bomb?
      else
        board[x,y].flag
      end
    end
  end
end


if $PROGRAM_NAME == __FILE__
  game = Minesweeper.new()
  game.play
end
