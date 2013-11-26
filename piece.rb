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

  def on_board?(x, y)
    [x, y].all? { |coord| coord.between?(0, 7) }
  end

  def valid_move?(x, y)
    return false unless on_board?(pos)
    (@board.empty?([x, y]) || @color != @board[x, y].color)
  end
end

