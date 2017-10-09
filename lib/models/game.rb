class Game
  attr_accessor :current_player, :board

  def initialize(human:, computer:, board:)
    @human = human
    @computer = computer
    @board = board

    @human.board = board
    @computer.board = board

    @current_player = (rand(0..1) == 1 ? human : computer)
  end

  def switch_turn
    @current_player = (@current_player.is_a?(Human) ? @computer : @human)
  end
end
