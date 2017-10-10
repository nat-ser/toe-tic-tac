class Game
  include WinCheckable

  attr_accessor :current_player, :board

  def initialize(human:, computer:, board:)
    @human = human
    @computer = computer
    @board = board

    @human.board = board
    @computer.board = board

    @current_player = (rand(0..1) == 1 ? human : computer)
  end

  def play
    # binding.pry
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
    play
  end
end
