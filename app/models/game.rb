class Game < ApplicationRecord
  has_many :pieces
  belongs_to :user

  validates :game_title, presence: true, length: { minimum: 3,
    maximum: 30 }

  def checkmate?(color)
    # find the king
    checked_king = self.pieces.where(piece_type: "King",piece_color: color).last


    return false unless side_in_check?(color)
     # if its in check
    return true if side_in_check?(color) && !checked_king.move_out_of_check?

    # check if the king can get out of check
    return false if checked_king.move_out_of_check?
    return true if !checked_king.move_out_of_check?
    return false if checked_king.can_be_captured?



    # can the king be captured
    # note I may not need this code below
    #return true if checked_king.can_be_captured?
  end


  # def in_check?(color)
  #   king = Piece.where(piece_type: "King", color: color)

  #   # get oppenents with opposite color
  #   opponents = Piece.where.not(piece_color:color).all

  #   opponents.each do |piece|
  #     if piece.valid_move?(king.x_coordinate, king.y_coordinate) == true
  #       return true
  #     end
  #   end
  #   return false
  # end

  def stalemate?(color)
    king = self.pieces.where(piece_type: "King", piece_color: color).last
    friendly_pieces = self.pieces.where(piece_color: king.piece_color).where.not(x_coordinate:nil, y_coordinate: nil, piece_type: "King").all

    return false if side_in_check?(king.piece_color) #can't be in check

    (0..7).to_a.each do |x|
      (0..7).to_a.each do |y|
        friendly_pieces.each do |friendly_piece|
          if (friendly_piece.valid_move?(x,y) && !side_in_check?(king.piece_color))
            puts friendly_piece.x_coordinate
            puts friendly_piece.y_coordinate
            puts friendly_piece.piece_type
            puts friendly_piece.piece_color
            puts total_valid_moves
            return false
          end
        end
      end
    end
    return true
  end






















  def in_check?
    side_in_check?("black") || side_in_check?("white")
  end

  def side_in_check?(color)
    enemy = color == "white" ? "black" : "white"
    #white king in check
    #white_king = nil
    #white_king_row = nil
    #white_king_col = nil
    if self.pieces.exists?(piece_type: "King", piece_color: color)
      king = self.pieces.where(piece_type: "King", piece_color: color).first
      king_row = king.y_coordinate
      king_col = king.x_coordinate
    end

    self.pieces.where(piece_color: enemy).each do |piece|
      if piece.piece_type != "Pawn" && !piece.x_coordinate.nil? && !piece.y_coordinate.nil?
        if piece.valid_move?(king_row, king_col)
          return true
        end
      end
    end

    #game.pieces.where(piece_type: "Bishop", piece_color: enemy).each do |bishop|
    #  if bishop.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Knight", piece_color: enemy).each do |knight|
    #  if knight.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Queen", piece_color: enemy).each do |queen|
    #  if queen.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "King", piece_color: enemy).each do |king|
    #  if king.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    self.pieces.where(piece_type: "Pawn", piece_color: enemy).each do |pawn|
      if !pawn.x_coordinate.nil? && !pawn.y_coordinate.nil?
        if pawn.can_capture?(king_row, king_col)
          return true
        end
      end
      #if pawn.y_coordinate + 1 == white_king_row && (pawn.x_coordinate - 1 == white_king_col || pawn.x_coordinate + 1 == white_king_col)
      #  return true
      #end
    end

    #black king in check
    #black_king = nil
    #black_king_row = nil
    #black_king_col = nil
    #if game.pieces.exists?(piece_type: "King", piece_color: "black")
    #  black_king = game.pieces.where(piece_type: "King", piece_color: "black").first
    #  black_king_row = black_king.y_coordinate
    #  black_king_col = black_king.x_coordinate
    #end

    #game.pieces.where(piece_type: "Rook", piece_color: "white").each do |rook|
    #  if rook.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Bishop", piece_color: "white").each do |bishop|
    #  if bishop.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Knight", piece_color: "white").each do |knight|
    #  if knight.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Queen", piece_color: "white").each do |queen|
    #  if queen.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "King", piece_color: "white").each do |king|
    #  if king.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Pawn", piece_color: "white").each do |pawn|
    #  if pawn.y_coordinate - 1 == black_king_row && (pawn.x_coordinate - 1 == black_king_col || pawn.x_coordinate + 1 == black_king_col)
    #   return true
    #  end
    #end

    false
  end

end
