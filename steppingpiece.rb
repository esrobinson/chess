require_relative 'piece'

class SteppingPiece < Piece

  def moves
    moves = []

    DIRECTIONS.each do |dir|
      x, y = @pos
      x_step, y_step = dir
      x += x_step
      y += y_step

      if on_board?([x, y])
        moves << [x, y] unless @color == @board[x, y].color
      end
    end

    moves
  end

end