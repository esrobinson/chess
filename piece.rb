class Piece
  SYMBOLS = {
    :w => {
      :King => "K",
      :Queen => "Q",
      :Rook => "R",
      :Bishop => "B",
      :Knight => "N",
      :Pawn => "P",
    },
    :b => {
      :King => "k",
      :Queen => "q",
      :Rook => "r",
      :Bishop => "b",
      :Knight => "n",
      :Pawn => "p",
    }
  }


  attr_reader :pos, :color

  def initialize(pos, color, board)
    @pos, @color, @board = pos, color, board
  end

  def move(x, y)
    unless moves.include?([x, y])
      raise InvalidMoveError, "Invalid Move."
    end
    move!(x,y)
  end

  def move!(x, y)
    @board.capture(x, y) unless @board.empty?(x, y)
    @pos = [x, y]
  end

  def moves
    raise NotImplementedError
  end

  def on_board?(x, y)
    [x, y].all? { |coord| coord.between?(0, 7) }
  end

  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return false unless (@board.empty?(x, y) || @color != @board[x, y].color)
    !move_into_check(x, y)
  end

  def move_into_check?(x, y)
    dup_board = @board.dup
    dup_board[@pos[0], @pos[1]].move!(x, y)
    dup_board.in_check?(@color)
  end

  def to_s
    SYMBOLS[@color][self.class.to_s.to_sym]
  end

  def dup
    self.class.new(@pos, @color, @board)
  end

end

