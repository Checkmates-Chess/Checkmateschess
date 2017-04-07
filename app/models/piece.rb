class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  self.inheritance_column = :piece_type

  def self.piece_types
    ["Pawn", "Knight", "Bishop", "Rook", "Queen", "King"]
  end

  scope :pawns, -> { where(piece_type: "Pawn") }
  scope :knights, -> { where(piece_type: "Knight") }
  scope :bishops, -> { where(piece_type: "Bishop") }
  scope :rooks, -> { where(piece_type: "Rook") }
  scope :queens, -> { where(piece_type: "Queen") }
  scope :kings, -> { where(piece_type: "King") }

  def move_to!(new_x, new_y)
    if valid_move?(new_x, new_y)
      if capturing_move?(new_x, new_y)
        # mark captured piece as captured
      end
      update(x_position: new_x, y_position: new_y)
    else
      return false
    end
  end
end



