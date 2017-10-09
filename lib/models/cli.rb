# gets input
# prints output
# displays board state
# gets inputs for different things
# validates input
require 'pry'

class CLI
  def self.run
    greet_player

    play(Human.new(player_name: ask_human_name, sign: ask_x_or_o),
     Computer.new)
  end

  def self.play(human, computer)
    game = Game.new(human: human, computer: computer)
    announce_first_player(game.current_player)

    display_board(game.board)
    while
      game.turn
      display_board(game.board)
    end
    display_board(game.board)
  end

  def self.valid_coordinate_map
    {
      q: 0, w: 1, e: 2,
      a: 3, s: 4, d: 5,
      z: 6, x: 7, c: 8,
    }
  end

  def self.square(key)
    valid_coordinate_map[key]
  end

  def self.display_board(board)
    formatted = board.squares.map { |square| square.class == Integer ? " " : square}

    puts " #{formatted[0]} | #{formatted[1]} | #{formatted[2]} "
    puts "------------"
    puts " #{formatted[3]} | #{formatted[4]} | #{formatted[5]} "
    puts "------------"
    puts " #{formatted[6]} | #{formatted[7]} | #{formatted[8]} "
    puts " "
  end

  def self.announce_first_player(first_player)
    if first_player.is_a?(Human)
      puts "congrats. you go first"
    else
      puts "computer won the draw"
    end
  end

  def self.greet_player
    puts "Hello"
  end

  def self.give_directions
    # TODO make these actial directions
    puts "directions"
  end

  def self.prompt_human(player_name:, board:)
    puts "what's your move #{player_name}?"
    key = gets.chomp.to_sym

    until valid_key?(key) && free_spot?(board: board, square: square(key))
      puts "please enter one of these: #{valid_coordinate_map.keys} in a free spot"
      key = gets.chomp.to_sym
    end
    square(key)
  end

  def self.ask_x_or_o
    puts "do you prefer to play with an x or an o?"
    sign = gets.chomp
    until valid_sign_choice?(sign)
      puts "X OR O"
      sign = gets.chomp
    end
    sign
  end

  def self.ask_human_name
    puts "What's your name?"
    gets.chomp
  end

  def self.valid_key?(key)
    valid_coordinate_map.keys.include?(key)
  end

  def self.free_spot?(board:, square:)
    board.free_squares.include?(square)
  end

  # def self.display_error_message(key)
  #   if !valid_key?(key)
  #     puts "please enter one of these: #{valid_coordinate_map.keys}"
  #   else
  #     puts "this spot is taken"
  #   end
  # end

  def self.valid_sign_choice?(sign)
    ["x", "o"].include?(sign)
  end
end
