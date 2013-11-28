require_relative 'king'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'
require 'colorize'

class Board
  def initialize
    @pieces = starting_position(:w) + starting_position(:b)
  end

  def empty?(x, y)
    self[x, y].nil?
  end

  def [](x, y)
    @pieces.find { |piece| piece.pos == [x, y] }
  end

  def move(start_pos, end_pos, color)
    check_move(start_pos, end_pos, color)
    piece_to_move = self[start_pos[0], start_pos[1]]
    move_result = piece_to_move.move(end_pos[0], end_pos[1])
    handle_en_passant(start_pos, end_pos, piece_to_move)
    move_result
  end

  def check_move(start_pos, end_pos, color)
    raise NoMoveError if start_pos.nil? || end_pos.nil?
    raise NoPieceError if empty?(start_pos[0], start_pos[1])
    raise WrongColorError if self[start_pos[0], start_pos[1]].color != color
  end

  def en_passant_pos?(x, y)
    return false if @en_passant.nil?
    [x, y] == @en_passant[:pos]
  end

  def handle_en_passant(start_pos, end_pos, piece_to_move)
    if piece_to_move.is_a?(Pawn) && en_passant_pos?(end_pos[0], end_pos[1])
      @pieces.delete(@en_passant[:piece])
    end
    @en_passant = nil
    return unless piece_to_move.is_a?(Pawn)
    return unless (start_pos[1] - end_pos[1]).abs > 1
    @en_passant = { piece: piece_to_move,
       pos: [start_pos[0], (start_pos[1] + end_pos[1])/2 ] }
  end

  def capture(x, y)
    @pieces.delete(self[x, y])
  end

  def in_check?(color)
    @pieces.any? { |piece| piece.moves.include?( king(color).pos ) }
  end

  def checkmate?(color)
    in_check?(color) && @pieces.none? do |piece|
      piece.color == color && piece.can_move?
    end
  end

  def dup
    dup_board = Board.new()
    dup_board.pieces = @pieces.map{ |piece| piece.dup(dup_board) }
    dup_board
  end

  def to_s
    files = "  A B C D E F G H\n"
    ranks = ["1 ","2 ","3 ","4 ","5 ","6 ","7 ","8 "]
    files +
    (0..7).map do |rank|
      ranks[rank] + (0..7).map do |file|
        if empty?(file, rank)
          "  ".colorize(background: (rank+file).even? ? :light_black : :light_white)
        else
          self[file, rank].to_s
          .colorize(background: (rank+file).even? ? :light_black : :light_white)
        end
      end.join("")

    end.reverse.join("\n")
  end

  def promote_pawn(end_pos, chosen_piece)
    pawn = self[end_pos[0], end_pos[1]]
    position, color = pawn.pos, pawn.color
    @pieces.delete(pawn)
    @pieces << chosen_piece.new(position, color, self)
  end

  protected
    attr_accessor :pieces

  private

    def starting_position(color)
      back_rank = (color == :w) ? 0 : 7
      pawn_rank = (color == :w) ? 1 : 6
      piece_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

      starting_pieces = piece_classes.each_with_index.map do |piece_class, i|
        piece_class.new([i, back_rank], color, self)
      end

      8.times do |file|
        starting_pieces << Pawn.new([file, pawn_rank], color, self)
      end

      starting_pieces
    end

    def king(color)
      @pieces.find { |piece| piece.is_a?(King) && piece.color == color }
    end

end




