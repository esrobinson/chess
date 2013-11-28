require_relative 'board'
require_relative 'human_player'
require 'yaml'

class Game

  def initialize(white_player, black_player)
    @board = Board.new
    @white = white_player.set_color(:w)
    @black = black_player.set_color(:b)
  end

  def play
    current_player, next_player = @white, @black
    until @board.checkmate?(current_player.color)
      begin
        puts @board
        make_move(current_player)
      rescue MoveError => e
        puts e.message
        retry
      end
      current_player, next_player = next_player, current_player
    end
    puts "#{next_player.name} wins by checkmate!"
  end

  private

    def make_move(current_player)
      puts "#{current_player.color == :w ? "White" : "Black"} to move."
      start_pos, end_pos = current_player.move
      result = @board.move(start_pos, end_pos, current_player.color)

      promote_pawn(current_player, end_pos) if result == :p
    end

    def promote_pawn(current_player, end_pos)
      chosen_piece = current_player.choose_pawn_promotion
      @board.promote_pawn(end_pos, chosen_piece)
    end
end


# if __FILE__ == $PROGRAM_NAME
  h1 = HumanPlayer.new('White')
  h2 = HumanPlayer.new('Black')
  g = Game.new(h1, h2)
  g.play
# end