require_relative 'piece'

class Pawn < Piece

  def initialize(pos, color, board)
    super(pos, color, board)
    @moved = false
  end

  def move(pos)
    super(pos)
    @moved = true
  end

  def moves
    moves = []

    x, y = @pos
    y_step = @color == :w ? 1 : -1
    y += y_step

    if valid_move?(x, y) && @board.empty?(x, y)
      moves << [x, y]
      unless @moved
        moves << [x, y + y_step] if valid_move?(x, y) && @board.empty?(x, y)
      end
    end

    moves << [x-1, y] if valid_move?(x-1, y) && !@board.empty?(x-1, y)
    moves << [x+1, y] if valid_move?(x+1, y) && !@board.empty?(x+1, y)

  end

end

