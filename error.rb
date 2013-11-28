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

class WrongColorError < MoveError
  def initialize(msg = "Can't move other player's pieces")
    super
  end
end

class NoMoveError < MoveError
  def initialize(msg = "You didn't input a move")
    super
  end
end

class PawnChoiceError < StandardError
  def initialize(msg = "Choose one of the given pieces")
    super
  end
end