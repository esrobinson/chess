require_relative 'slidingpiece'

class Queen < SlidingPiece
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

end