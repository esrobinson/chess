require_relative 'steppingpiece'

class Knight < SteppingPiece
  DIRECTIONS = [
    [-2,  1],
    [-1,  2],
    [ 1,  2],
    [ 2,  1],
    [ 2, -1],
    [ 1, -2],
    [-1, -2],
    [-2, -1]
  ]

end