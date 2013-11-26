class Piece
  def initialize(pos, color, board)
    @pos, @color, @board = pos, color, board
  end

  def move(pos)
    @pos = pos
  end

  def moves
    raise NotImplementedError
  end
end

