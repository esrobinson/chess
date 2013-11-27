require_relative 'piece'

class SlidingPiece < Piece

  def moves
    moves = []

    self.class::DIRECTIONS.each do |dir|
      x, y = @pos
      x_step, y_step = dir
      x += x_step
      y += y_step

      while valid_move?(x,y)
        moves << [x, y]
        break unless @board.empty?(x, y)
        x += x_step
        y += y_step
      end

      moves
    end

    moves
  end
end
