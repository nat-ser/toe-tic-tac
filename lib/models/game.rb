require 'pry'
class Game
  attr_reader :board, :human, :computer

  def initialize(human_name:, computer_name:)
    @human = Human.new(human_name)
    @computer = Computer.new(computer_name)
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @human.board = @board
    @computer.board = @board
  end

  def display_board
    puts " #{board[0][0]} | #{board[0][1]} | #{board[0][2]} "
    puts "--------"
    puts " #{board[1][0]} | #{board[1][1]} | #{board[1][2]} "
    puts "--------"
    puts " #{board[2][0]} | #{board[2][1]} | #{board[2][2]} "
    puts " "
  end

  def ongoing?
    board.flatten.any?(&:nil?)
  end

  def play
    display_board
    computer.move
    display_board
    CLI.prompt_human(human)
    human.move
  end
end

class CLI
  def self.prompt_human(human)
    puts "Your turn #{human.player_name}"
  end

  def self.user_input
    gets.chomp
  end
end

class Player
  attr_reader :player_name
  attr_accessor :board

  def initialize(player_name)
    @player_name = player_name
  end

  def update_square(content:, x:, y:)
    board[x][y] = content
  end

  def win

  end
end

class Human < Player
  def move
    key = CLI.user_input.to_sym
    update_square(content: "x", x: coordinates[key][0], y: coordinates[key][1])
  end

  def coordinates
    {
      q: [0, 0], w: [0, 1], e: [0, 2],
      a: [1, 0], s: [1, 1], d: [1, 2],
      z: [2, 0], x: [2, 1], c: [2, 2]
    }
  end
end

class Computer < Player
  def move
    x, y = rand(0..2), rand(0..2)
    random_spot = board[x][y]
    while !!random_spot
      random_spot = board[x][y]
    end
    update_square(content: "o", x: x, y: y)
  end
end
