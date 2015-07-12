class Board 
  attr_reader :grid, :last_move, :game_won, :game_status

  def initialize
    @grid = [['empty', 'empty', 'empty'], ['empty', 'empty', 'empty'], ['empty', 'empty', 'empty']]
    @game_over = false
    @game_status = "Ongoing"
  end

  def show_board
    puts "#{@grid[0][0]}".center(7) + '|' + "#{@grid[1][0]}".center(7) + '|' + "#{@grid[2][0]}".center(7)
    puts '-'*23
    puts "#{@grid[0][1]}".center(7) + '|' + "#{@grid[1][1]}".center(7) + '|' + "#{@grid[2][1]}".center(7) 
    puts '-'*23
    puts "#{@grid[0][2]}".center(7) + '|' + "#{@grid[1][2]}".center(7) + '|' + "#{@grid[2][2]}".center(7) 
  end

  def place_piece(vertical, horizontal, piece)
    grid[horizontal][vertical] = piece
    @last_move = piece
  end

  def possible_move?(vertical, horizontal)
    if @grid[horizontal][vertical] == 'empty'
      true
    else
      false
    end
  end

  def find_possible_moves

    count = 0 
    horizontal_coord = 0
    list_array = []

    @grid.each do |row|
      vertical_coord = 0
      row.each do |cell|
        if cell == 'empty'
          vertical_spot = case vertical_coord
            when 0 then 'top'
            when 1 then 'middle'
            else 'bottom'
            end
          horizontal_spot = case horizontal_coord
            when 0 then 'left'
            when 1 then 'center'
            else 'right'
            end
          list_array[count] = []
          list_array[count][0] = vertical_spot + ' ' + horizontal_spot
          list_array[count][1] = [vertical_coord, horizontal_coord]
          count += 1
        end
        vertical_coord += 1
      end
      horizontal_coord += 1
    end
    return list_array
  end

  def print_possible_moves
    count = 0
    self.find_possible_moves.each do |choice| 
      puts "#{count}. #{choice[0].capitalize}"
      count += 1
    end
  end

  def move_to_coordinates(n)
    self.find_possible_moves[n][0]
  end

  def game_over?
    if (grid[0][0] == grid[1][1] && grid[0][0] == grid[2][2]) ||
       (grid[0][2] == grid[1][1] && grid[0][2] == grid[2][0]) &&
       (grid[1][1] != 'empty')
      @game_status = 'Winner'
      return @game_over = true
    end
    (0..2).each do |n|
      if ((grid[0][n] == grid[1][n] && grid[0][n] == grid[2][n]) ||
         (grid[n][0] == grid[n][1] && grid[n][0] == grid[n][2])) &&
         ((grid[0][n] != 'empty') && (grid[n][0] != 'empty'))
        @game_status = 'Winner'
        return @game_over = true
      elsif @game_over == false && self.find_possible_moves.length == 0
        @game_status = 'Tied'
        return @game_over = true
      else
        @game_over = false
      end
    end
    return @game_over
  end
end

class PlayerPair
  attr_accessor :x_player, :o_player

  def initialize(game)
    @game = game
  end
end

def run
  loop do 
    puts 'Would you like to play a game? Yes or no:'
    if gets.chomp!.downcase != 'yes'
      return 'Maybe next time'
    else
      game = Board.new
      pair = PlayerPair.new(game)
      puts "What is the name of the player using X's?"
      pair.x_player = gets.chomp!
      puts"And the O's player?"
      pair.o_player = gets.chomp!
      puts "Excellent, X's go first!"
      game.show_board
      piece_count = 0
      piece = 'X'
      loop do
        piece = piece_count.even? ? 'X' : 'O'
        current_player = piece_count.even? ? pair.x_player : pair.o_player
        move = -1
        while move < 0 || move > game.find_possible_moves.length - 1
          puts "#{current_player}, please enter a valid number corresponding to your desired move:"
          game.print_possible_moves
          move = gets.chomp!.to_i
        end
        coords = game.find_possible_moves[move][1]
        game.place_piece(coords[0], coords[1], piece)
        game.show_board
        piece_count += 1
        break if game.game_over?
      end
      if game.game_status == 'Winner'
        puts "#{game.last_move} won!"
      else
        puts 'Game was tied!'
      end
    end
  end
end

# run
# sup = Board.new
# puts sup.find_possible_moves.length