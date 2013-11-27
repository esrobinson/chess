class MoveError < StandardError
end

class NoPieceError < MoveError
  def initialize(msg = "No piece at starting position.")
    super
  end
end

class InvalidMoveError < MoveError
  def initialize(msg = "Invalid move.")
    super
  end
end

class MovedIntoCheckError < MoveError
  def initialize(msg = "Can't move into check.")
    super
  end
end