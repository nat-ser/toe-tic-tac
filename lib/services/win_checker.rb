class WinChecker
  class << self
    def win_or_tie?(game)
      false
    end

    def victories
      horizontal_victories + vertical_victories + diagonal_victories
    end

    def horizontal_victories
    end

    def vertical_victories
    end

    def diagonal_victories
    end
  end
end
