require 'pry'

class CLI
  class << self
    def run
      introduction

      human, computer, board = Human.new, Computer.new, Board.new
      game = Game.new(human: human, computer: computer, board: board)

      set_player_signs(human: human, computer: computer)
      announce_random_first_player(game.current_player)

      game.play
    end

    def ask_where_move(free_squares)
      puts "what's your move human?"
      square = key_to_square_map[gets.chomp.to_sym]
      until valid_square?(square) && empty_square?(square: square, free_squares: free_squares)
        puts "please enter one of these: #{key_to_square_map.keys} in a free spot"
        square = key_to_square_map[gets.chomp.to_sym]
      end
      square
    end

    def display_board(board)
      formatted = board.squares.map { |square| square.class == Integer ? " " : square}

      puts " #{formatted[0]} | #{formatted[1]} | #{formatted[2]} "
      puts "------------"
      puts " #{formatted[3]} | #{formatted[4]} | #{formatted[5]} "
      puts "------------"
      puts " #{formatted[6]} | #{formatted[7]} | #{formatted[8]} "
      puts " "
    end

    def play_again?
      puts "Do you want to play again? (y/n) >"
      exit_choice = gets.chomp.downcase
      if exit_choice == 'y'
        CLI.run
      elsif exit_choice == 'n'
        exit!
      else
        play_again?
      end
    end

    private

    def introduction
      puts "You are playing toe-tic-tac! Enter 'exit' at any time to quit the game"
      puts "To move, you can enter these keys on the left-hand side of your keyboard
      q | w | e
      ---------
      a | s | d
      ---------
      z | x | c "

    end

    def set_player_signs(human:, computer:)
      human.sign = ask_x_or_o?
      computer.sign = ( human.sign == "x" ? "o" : "x" )
    end

    def ask_x_or_o?
      puts "do you prefer to play with an x or an o?"
      sign = gets.chomp

      until valid_sign_choice?(sign)
        puts "X OR O"
        sign = gets.chomp
      end
      sign
    end

    def valid_sign_choice?(sign)
      ["x", "o"].include?(sign)
    end

    def announce_random_first_player(current_player)
      if current_player.is_a?(Human)
        puts "congrats. you go first!"
      else
        puts "computer won the draw"
      end
    end

    def key_to_square_map
      {
        q: 0, w: 1, e: 2,
        a: 3, s: 4, d: 5,
        z: 6, x: 7, c: 8,
      }
    end

    def valid_square?(square)
      (0..8).to_a.include?(square)
    end

    def empty_square?(square:, free_squares:)
      free_squares.include?(square)
    end

  end
end
