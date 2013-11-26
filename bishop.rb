require_relative 'slidingpiece'

class Bishop < SlidingPiece
  DIRECTIONS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
end