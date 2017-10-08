class Game
  attr_accessor :board, :human, :computer, :current_player

  def initialize(human:, computer:)
    # TODO dont hardcode
    @board = Board.new([ 0, 1, 2, 3, 4, 5, 6, 7, 8])
    @board_dimension = Math.sqrt(@board.squares.length)
    @human = human
    @computer = computer
    set_computer_sign
    @human.board = @board
    @computer.board = @board
    randomize_first_move
  end

  def victory?
    # horizontal_victory?
    vertical_victory?
    # horizontal_victory? || diagonal_victory? || vertical_victory?
  end

  def vertical_victory?
    sign = current_player.sign
    squares = board.squares
    increment = @board_dimension - 1

    counts = (0..increment)
    markers = (0..increment).each do |marker|
      counts[marker] = 1 if squares[marker] == sign
    end
    puts "MARKERS #{markers}"
    squares.each_with_index do |square, idx|
      next if idx < increment
    false

  end

  def horizontal_victory?
    sign = current_player.sign
    increment = @board_dimension - 1
    squares = board.squares
    pointer = 0
    while pointer < squares.length
      segment = squares[pointer..(pointer + increment)]
      condition_met = segment.all? { |square| square == sign }
      if condition_met
        puts "#{current_player.player_name} won!"
        return true
      else
        pointer += increment
      end
    end
  end

  def diagonal_victory?
    false
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
      human.move(CLI.prompt_human(human.player_name))
      return if victory? || draw?
      @current_player = computer
    else
      computer.move
      return if victory? || draw?
      @current_player = human
    end
  end
end
