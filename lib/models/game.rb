class Game
  include WinCheckable

  attr_accessor :current_player, :board

  def initialize
    @human = Human.new
    @computer = Computer.new
    @board = Board.new
    @human.board = board
    @computer.board = board
    @current_player = (rand(0..1) == 1 ? @human : @computer)
  end

  def play
    current_player.take_turn(self)
    CLI.display_board(board)
    if win_or_tie? == :win
      current_player == @human ? (puts "human won") : (puts "computer won")
      CLI.play_again?
    elsif win_or_tie? == :tie
      puts "tie"
      CLI.play_again?
    else
      switch_turn
      play
    end
  end

  def switch_turn
    @current_player = (@current_player == @human ? @computer : @human)
  end

  def set_player_signs
    @human.sign = CLI.ask_x_or_o?
    @computer.sign = ( @human.sign == "x" ? "o" : "x" )
  end
end
