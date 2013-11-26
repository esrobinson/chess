require_relative 'steppingpiece'

class King < SteppingPiece
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