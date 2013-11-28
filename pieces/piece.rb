require_relative '../error'

class Piece
  SYMBOLS = {
    :w => {
      :King =>   "\u2654 ",
      :Queen =>  "\u2655 ",
      :Rook =>   "\u2656 ",
      :Bishop => "\u2657 ",
      :Knight => "\u2658 ",
      :Pawn =>   "\u2659 ",
    },
    :b => {
      :King =>   "\u265A ",
      :Queen =>  "\u265B ",
      :Rook =>   "\u265C ",
      :Bishop => "\u265D ",
      :Knight => "\u265E ",
      :Pawn =>   "\u265F ",
    }
  }

  attr_reader :pos, :color

  def initialize(pos, color, board)
    @pos, @color, @board = pos, color, board
  end

  def move(x, y)
    unless moves.include?([x, y])
      raise InvalidMoveError
    end

    raise MovedIntoCheckError if move_into_check?(x, y)

    move!(x,y)
  end

  def moves
    raise NotImplementedError
  end

  def can_move?
    moves.any? { |x, y| !move_into_check?(x, y) }
  end

  def dup(new_board)
    self.class.new(@pos, @color, new_board)
  end

  def to_s
    SYMBOLS[@color][self.class.to_s.to_sym]
  end

  protected
    def move!(x, y)
      @board.capture(x, y) unless @board.empty?(x, y)
      @pos = [x, y]
      nil
    end

  private
    def on_board?(x, y)
      [x, y].all? { |coord| coord.between?(0, 7) }
    end

    def valid_move?(x, y)
      return false unless on_board?(x, y)
      (@board.empty?(x, y) || @color != @board[x, y].color)
    end

    def move_into_check?(x, y)
      dup_board = @board.dup
      dup_board[@pos[0], @pos[1]].move!(x, y)
      dup_board.in_check?(@color)
    end
end

