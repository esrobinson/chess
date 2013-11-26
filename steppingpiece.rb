require_relative 'piece'

class SteppingPiece < Piece

  def moves
    moves = []

    DIRECTIONS.each do |dir|
      x, y = @pos
      x_step, y_step = dir
      x += x_step
      y += y_step

      moves << [x, y] if valid_move?(x, y)
    end

    moves
  end

end