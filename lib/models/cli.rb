# gets input
# prints output
# displays board state
# gets inputs for different things
# validates input
require 'pry'

class CLI
  def self.run
    greet_player
    give_directions

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
  end

  def self.valid_coordinate_map
    {
      q: 0, w: 1, e: 2,
      a: 3, s: 4, d: 5,
      z: 6, x: 7, c: 8,
    }
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

  def self.prompt_human(human_name)
    puts "what's your move #{human_name}?"
    key = gets.chomp.to_sym
    until valid_move?(key, valid_coordinate_map)
      puts "please enter one of these: #{valid_coordinate_map.keys}"
      key = gets.chomp.to_sym
    end
    valid_coordinate_map[key]
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

  def self.valid_move?(key, valid_coordinate_map)
    valid_coordinate_map.keys.include?(key)
  end

  def self.valid_sign_choice?(sign)
    ["x", "o"].include?(sign)
  end
end
