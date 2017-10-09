class Game
  attr_accessor :board, :human, :computer, :current_player
  attr_reader :board_dimension, :indeces, :horizontal_victories, :vertical_victories, :diagonal_victories

  def initialize(human)
    # TODO dont hardcode
    @board = Board.new([ 0, 1, 2, 3, 4, 5, 6, 7, 8])
    @human = human
    human.board = @board_dimension
    @computer = Computer.new(board: @board)
    @computer.sign = ( @human.sign == "x" ? "o" : "x" )

    WinChecker.new(@board)
    randomize_first_move
  end

  def set_computer_sign
    @computer.sign = ( @human.sign == "x" ? "o" : "x" )
  end

  def draw?
    board.free_squares.empty?
  end

  def randomize_first_move
    @current_player = ( rand(0..1) == 1 ? human : computer )
  end

  def turn
    if current_player.is_a?(Human)
      human.move(CLI.prompt_human(player_name: human.player_name, board: board))
    else
      puts "computer's move:"
      computer.move
    end
    return if end_game_if_win_or_draw

    @current_player = (current_player.is_a?(Human) ? computer : human)
  end

  def end_game_if_win_or_draw
    if victory?
      puts current_player.is_a?(Human) ? "yay #{current_player.player_name} won!" : "computer won"
      true
    elsif draw?
      puts "TIE"
      true
    end
  end
end
