class Player
  attr_accessor :board

  def update_free_squares(square_name)
    board.free_squares.delete(square_name)
  end

  def populate_square(square_name:, sign:)
    update_free_squares(square_name)
    board.squares[square_name] = sign
  end
end

class Computer < Player
  attr_accessor :sign

  def move
    random_index = board.free_squares[rand(board.free_squares.length)]
    square_name = board.squares[random_index]
    populate_square(square_name: square_name, sign: sign)
  end
end

class Human < Player
  attr_reader :player_name, :sign

  def initialize(player_name:, sign:)
    @player_name = player_name
    @sign = sign
  end

  def move(square_name)
    populate_square(square_name: square_name, sign: sign)
  end
end
