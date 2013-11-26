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

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end
end

