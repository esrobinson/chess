require_relative 'king'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'

class Board
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

  def capture(x, y)
    @pieces.delete(self[x, y])
  end

  def to_s
    (0..7).map do |rank|
      (0..7).map do |file|
        if empty?(file, rank)
          "*"
        else
          self[file, rank].to_s
        end
      end.join(" ")
    end.reverse.join("\n")
  end

end




