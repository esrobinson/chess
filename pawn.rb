require_relative 'piece'

class Pawn < Piece
  def moves
    moves = []

    x, y = @pos
    y_step = @color == :w ? 1 : -1
    y += y_step

    if valid_move?(x, y) && @board.empty?(x, y)
      moves << [x, y]
      unless moved?
        moves << [x, y + y_step] if @board.empty?(x, y + y_step)
      end
    end

    moves << [x-1, y] if valid_move?(x-1, y) && !@board.empty?(x-1, y)
    moves << [x+1, y] if valid_move?(x+1, y) && !@board.empty?(x+1, y)

    moves
  end

  def move(x, y)
    super
    :p if pos[1] == (@color == :w ? 7 : 0)
  end

  private

    def moved?
      return @pos[1] != 1 if color == :w
      return @pos[1] != 6
    end

end

