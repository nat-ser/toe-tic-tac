class Game


  def initialize(player:, computer:)
    @player = player
    @computer = computer
    @board = board
  end

  def board
    ([] << Array.new(3)) * 3
  end

  def display_board
    puts " #{board[0][0]} | #{board[0][1]} | #{board[0][2]} "
    puts "--------"
    puts " #{board[1][0]} | #{board[1][1]} | #{board[1][2]} "
    puts "--------"
    puts " #{board[2][0]} | #{board[2][1]} | #{board[2][2]} "
  end
end


