require_relative 'steppingpiece'

class King < SteppingPiece
  attr_reader :moved

  DIRECTIONS = [
    [-1,  0],
    [ 0, -1],
    [ 0,  1],
    [ 1,  0],
    [-1, -1],
    [-1,  1],
    [ 1, -1],
    [ 1,  1]
    ]

  def initialize(pos, color, board)
    super
    @moved = false
  end

  def move(x, y)
    super
    @moved = true
  end

  def castle(side)
    file = side == :l ? 2 : 6
    move!(file, @pos[1])
    @moved = true
  end

end