require_relative 'slidingpiece'

class Rook < SlidingPiece
  DIRECTIONS = [[-1, 0], [0, -1], [0, 1], [1, 0]]
end