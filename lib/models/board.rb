class Board
  attr_accessor :squares
  attr_reader :free_squares, :dimension, :indeces

# to modify board size - would initialize board with a diff size
  def initialize
    @squares = (0..8).to_a
    @free_squares = squares.dup
    @dimension = Math.sqrt(@squares.length).to_i
    @indeces = (squares.dup)
  end

  def update_free_squares(square)
    free_squares.delete(square)
  end
end
