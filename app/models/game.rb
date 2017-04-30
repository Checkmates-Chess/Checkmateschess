class Game < ApplicationRecord
  has_many :pieces
  belongs_to :user

  validates :game_title, presence: true, length: { minimum: 3,
    maximum: 30 }

  def checkmate?(color)
    # find the king
    checked_king = self.pieces.where(piece_type: "King",piece_color: color).last
    return false unless side_in_check?(color)
    !checked_king.move_out_of_check?
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
            Rails.logger.info("x: #{friendly_piece.x_coordinate}
                              y: #{friendly_piece.y_coordinate}
                              piece_type: #{friendly_piece.piece_type}
                              piece_color: #{friendly_piece.piece_color}
              ")
            return false
          end
        end
      end
    end
    true
  end






















  def in_check?
    side_in_check?("black") || side_in_check?("white")
  end

  def side_in_check?(color)
    enemy_color = color == "white" ? "black" : "white"
    king = pieces.kings.color(color).first
    king_row = king&.y_coordinate
    king_col = king&.x_coordinate

    pieces.color(enemy_color).each do |piece|
      if !piece.pawn? && piece.x_coordinate && piece.y_coordinate
        if piece.valid_move?(king_row, king_col)
          return true
        end
      end
    end

    pieces.pawns.color(enemy_color).each do |pawn|
      if !pawn.x_coordinate.nil? && !pawn.y_coordinate.nil?
        if pawn.can_capture?(king_row, king_col)
          return true
        end
      end
    end
    false
  end

end
