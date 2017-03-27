class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  self.inheritance_column = :piece_type

  def self.piece_types
    ["Pawn", "Knight", "Bishop", "Rook", "Queen", "King"]
  end
end
