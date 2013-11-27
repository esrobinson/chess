class MoveError < StandardError
end

class NoPieceError < MoveError
end

class InvalidMoveError < MoveError
end