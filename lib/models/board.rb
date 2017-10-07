class Board
  attr_accessor :squares
  attr_reader :free_squares

# initializing for now in case the board changes (more squares)
  def initialize(squares)
    @free_squares = squares.dup
    @squares = squares
  end
end
