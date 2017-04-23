class Game < ApplicationRecord
  has_many :pieces
  belongs_to :user

  validates :game_title, presence: true, length: { minimum: 3,
    maximum: 30 }

  def checkmate?(color)
    # find the king
    checked_king = Piece.where(piece_type: "King",piece_color: color)

    # if its in check
    return true if in_check?(color)

    # can the king be captured
    return true if checked_king.can_be_captured?

    # check if the king can get out of check
    return true if !checked_king.move_out_of_check?
  end

  def in_check?(color)
    king = Piece.where(piece_type: "King", color: color)

    # get oppenents with opposite color
    opponents = Piece.where.not(piece_color:color).all

    opponents.each do |piece|
      if piece.valid_move?(king.x_coordinate, king.y_coordinate) == true
        return true
      end
    end
    return false
  end

  def stalemate?(color)
    king = Piece.where(piece_type: "King", piece_color: color)
    return true if in_check?(color) && !king.move_out_of_check?
  end






















  # # uses valid_move method for each enemy piece type in relation to king location
  # # ...except for Pawn, where we check forward diagonals (valid move for pawn includes
  # # movement where it can't capture)
  # def in_check?
  #   side_in_check?("black") || side_in_check?("white")
  # end

  # def side_in_check?(color)
  #   enemy = color == "white" ? "black" : "white"
  #   #white king in check
  #   #white_king = nil
  #   #white_king_row = nil
  #   #white_king_col = nil
  #   if game.pieces.exists?(piece_type: "King", piece_color: color)
  #     king = game.pieces.where(piece_type: "King", piece_color: color).first
  #     king_row = king.y_coordinate
  #     king_col = king.x_coordinate
  #   end

  #   game.pieces.where(piece_color: enemy).each do |piece|
  #     if piece.piece_type != "Pawn" && !piece.x_coordinate.nil? && !piece.y_coordinate.nil?
  #       if piece.valid_move?(king_row, king_col)
  #         return true
  #       end
  #     end
  #   end

  #   #game.pieces.where(piece_type: "Bishop", piece_color: enemy).each do |bishop|
  #   #  if bishop.valid_move?(white_king_row, white_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "Knight", piece_color: enemy).each do |knight|
  #   #  if knight.valid_move?(white_king_row, white_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "Queen", piece_color: enemy).each do |queen|
  #   #  if queen.valid_move?(white_king_row, white_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "King", piece_color: enemy).each do |king|
  #   #  if king.valid_move?(white_king_row, white_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   game.pieces.where(piece_type: "Pawn", piece_color: enemy).each do |pawn|
  #     if !pawn.x_coordinate.nil? && !pawn.y_coordinate.nil?
  #       if pawn.can_capture?(king_row, king_col)
  #         return true
  #       end
  #     end
  #     #if pawn.y_coordinate + 1 == white_king_row && (pawn.x_coordinate - 1 == white_king_col || pawn.x_coordinate + 1 == white_king_col)
  #     #  return true
  #     #end
  #   end

  #   #black king in check
  #   #black_king = nil
  #   #black_king_row = nil
  #   #black_king_col = nil
  #   #if game.pieces.exists?(piece_type: "King", piece_color: "black")
  #   #  black_king = game.pieces.where(piece_type: "King", piece_color: "black").first
  #   #  black_king_row = black_king.y_coordinate
  #   #  black_king_col = black_king.x_coordinate
  #   #end

  #   #game.pieces.where(piece_type: "Rook", piece_color: "white").each do |rook|
  #   #  if rook.valid_move?(black_king_row, black_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "Bishop", piece_color: "white").each do |bishop|
  #   #  if bishop.valid_move?(black_king_row, black_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "Knight", piece_color: "white").each do |knight|
  #   #  if knight.valid_move?(black_king_row, black_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "Queen", piece_color: "white").each do |queen|
  #   #  if queen.valid_move?(black_king_row, black_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "King", piece_color: "white").each do |king|
  #   #  if king.valid_move?(black_king_row, black_king_col)
  #   #    return true
  #   #  end
  #   #end
  #   #game.pieces.where(piece_type: "Pawn", piece_color: "white").each do |pawn|
  #   #  if pawn.y_coordinate - 1 == black_king_row && (pawn.x_coordinate - 1 == black_king_col || pawn.x_coordinate + 1 == black_king_col)
  #   #   return true
  #   #  end
  #   #end

  #   false
  # end


end
