module WinCheckable
  def win_or_tie?
    if victory?
      :win
    elsif tie?
      :tie
    end
  end

  def wins
    @wins ||= begin
      (horizontal_win_combinations + vertical_win_combinations + diagonal_win_combinations)
    end
  end

  def horizontal_win_combinations
    row_wins = []
    pointer = 0
    # number of rows
    board.dimension.times do
      # array of each row combination
      row_combinations = (pointer...(pointer + board.dimension)).to_a
      row_wins << row_combinations
      pointer += board.dimension
    end
    row_wins
  end

  def vertical_win_combinations
    column_wins = []
    # empty array of column combination arrays
    board.dimension.times { column_wins << []}

    column_number = 0
    board.indeces.each do |idx|
      # put an index from each column in respective column win combination
      column_wins[column_number] << board.indeces[idx]

      # if idx + 1 is a multiple if the dimension, start distributing to the first column again
      if idx_multiple_of_dimension?(idx)
        column_number = 0
      else
        column_number += 1
      end
    end
    column_wins
  end

  def idx_multiple_of_dimension?(idx)
      square_count = idx + 1
      (square_count % board.dimension == 0)
  end

  def diagonal_win_combinations
    # there will always be 2 diagonal wins
    diagonal_wins = [[], []]
    first_pointer = 0
    first_increment = board.dimension + 1
    board.dimension.times do
      diagonal_wins[0] << board.indeces[first_pointer]
      first_pointer += first_increment
    end

    second_pointer = board.dimension - 1
    second_increment = board.dimension - 1
    board.dimension.times do
      diagonal_wins[1] << board.indeces[second_pointer]
      second_pointer += second_increment
    end
    diagonal_wins
  end

  def victory?
    wins.each do |win|
      return true if (win - current_player.player_squares).empty?
    end
    false
  end

  def tie?
    board.free_squares.empty?
  end
end
