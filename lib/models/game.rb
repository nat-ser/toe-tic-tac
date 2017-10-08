class Game
  attr_accessor :board, :human, :computer, :current_player
  attr_reader :board_dimension, :indeces, :horizontal_victories, :vertical_victories, :diagonal_victories

  def initialize(human:, computer:)
    # TODO dont hardcode
    @board = Board.new([ 0, 1, 2, 3, 4, 5, 6, 7, 8])
    @human = human
    @computer = computer
    set_computer_sign

    @human.board = @board
    @computer.board = @board

    @board_dimension = Math.sqrt(@board.squares.length).to_i
    @indeces = (0..@board.squares.length).to_a
    @increment = @board_dimension - 1
    @first_row = (0..@increment).to_a

    @horizontal_victories = set_horizontal_victories
    @vertical_victories = set_vertical_victories
    @diagonal_victories = set_diagonal_victories
    randomize_first_move
  end

  def victory?
    type_victory?(@horizontal_victories) || type_victory?(@vertical_victories) || type_victory?(@diagonal_victories)
  end

  def type_victory?(victories)
    victories.each do |vic|
      return true if (vic - (current_player.taken_squares)).empty?
    end
    false
  end

  def set_horizontal_victories
    pointer = 0
    victories = []

    @board_dimension.times do
      victories << ((pointer..(pointer + @increment)).to_a)
      pointer += @board_dimension
    end
    victories
  end

  def set_vertical_victories
    victories = []
    @board_dimension.times { victories << []}

    @first_row.each do |victory_idx|
      pointer = victory_idx
      @board_dimension.times do
        victories[victory_idx] << @indeces[pointer]
        pointer += @board_dimension
      end
    end
    victories
  end


  def set_diagonal_victories
    victories = [[], []]

    pointer = 0
    first_increment = @board_dimension + 1
    @board_dimension.times do
      victories[0] << @indeces[pointer]
      pointer += first_increment
    end

    second_increment = @board_dimension - 1
    pointer = @increment
    @board_dimension.times do
      victories[1] << @indeces[pointer]
      pointer += second_increment
    end
    victories
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
    else
      computer.move
    end

    if victory? || draw?
      puts "yay #{current_player.player_name} won!"
      return
    end
    @current_player = (current_player.is_a?(Human) ? computer : human)
  end
end
