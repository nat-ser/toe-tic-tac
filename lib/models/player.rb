class Player
  attr_accessor :sign, :board, :player_squares

  def initialize
    @player_squares = []
  end

  def populate_square(square:, sign:)
    board.update_free_squares(square)
    board.squares[square] = sign
  end

  def move_to(square)
    populate_square(square: square, sign: sign)
    player_squares << square
  end

  def take_turn(game)
    square = move
    move_to(square)
  end
end

class Computer < Player
  def move
    puts "computer's move"
    random_index = board.free_squares[rand(board.free_squares.length - 1)]
    board.squares[random_index]
  end
end

class Human < Player
  def move
    CLI.prompt_human_to_move(board)
  end
end
