class Game
  attr_accessor :board, :human, :computer, :current_player

  def initialize(human, computer)
    # TODO dont hardcode
    @board = Board.new([ 0, 1, 2, 3, 4, 5, 6, 7, 8])
    @human = human
    @computer = computer
    set_computer_sign
    @human.board = @board
    @computer.board = @board
    randomize_first_move
  end

  # def victory?
  # end

  def set_computer_sign
    @computer.sign = ( @human.sign == "x" ? "o" : "x" )
  end

  def draw?
    board.free_squares.empty?
  end

  def randomize_first_move
    current_player = ( rand(0..1) == 1 ? human : computer )
  end

  def switch_turn
    if current_player.is_a?(Human)
      human.move(CLI.prompt_human(human.player_name))
      @current_player = computer
    else
      computer.move
      @current_player = human
    end
  end
end
