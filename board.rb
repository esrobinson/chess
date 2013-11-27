require_relative 'king'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'

class Board
  attr_accessor :pieces

  def initialize
    @pieces = starting_position(:w) + starting_position(:b)
  end

  def empty?(x, y)
    self[x, y].nil?
  end

  def [](x, y)
    @pieces.find { |piece| piece.pos == [x, y] }
  end

  def starting_position(color)
    back_rank = (color == :w) ? 0 : 7
    pawn_rank = (color == :w) ? 1 : 6

    starting_pieces = []
    starting_pieces << Rook.new(  [0,back_rank], color, self)
    starting_pieces << Knight.new([1,back_rank], color, self)
    starting_pieces << Bishop.new([2,back_rank], color, self)
    starting_pieces << Queen.new( [3,back_rank], color, self)
    starting_pieces << King.new(  [4,back_rank], color, self)
    starting_pieces << Bishop.new([5,back_rank], color, self)
    starting_pieces << Knight.new([6,back_rank], color, self)
    starting_pieces << Rook.new(  [7,back_rank], color, self)

    8.times do |file|
      starting_pieces << Pawn.new([file, pawn_rank], color, self)
    end

    starting_pieces
  end

  def move(start_pos, end_pos)
    raise NoMoveError if empty?(start_pos[0], start_pos[1])
    self[start_pos[0], start_pos[1]].move(end_pos[0], end_pos[1])
  end

  def capture(x, y)
    @pieces.delete(self[x, y])
  end

  def king(color)
    @pieces.find { |piece| piece.is_a?(King) && piece.color == color }
  end

  def in_check?(color)
    @pieces.any? { |piece| piece.moves.include?( king(color).pos ) }
  end

  def checkmate?(color)
    in_check?(color) && @pieces.none? do |piece|
      piece.color == color && piece.can_move?
    end
  end

  def dup
    dup_board = Board.new()
    dup_board.pieces = @pieces.map{ |piece| piece.dup(dup_board) }
    dup_board
  end

  def to_s
    files = "  A B C D E F G H\n"
    ranks = ["1 ","2 ","3 ","4 ","5 ","6 ","7 ","8 "]
    files +
    (0..7).map do |rank|
      ranks[rank] + (0..7).map do |file|
        if empty?(file, rank)
          "*"
        else
          self[file, rank].to_s
        end
      end.join(" ")

    end.reverse.join("\n")
  end

end




