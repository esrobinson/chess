require_relative 'slidingpiece'

class Rook < SlidingPiece
  attr_reader :moved

  DIRECTIONS = [[-1, 0], [0, -1], [0, 1], [1, 0]]

  def initialize(pos, color, board)
    super
    @moved = false
  end

  def move(x, y)
    super
    @moved = true
  end

end