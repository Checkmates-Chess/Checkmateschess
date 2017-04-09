class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  self.inheritance_column = :piece_type

  BOARD_SIZE = 8

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
        piece = Piece.where(x_coordinate:x, y_coordinate: y).last
        piece.mark_as_captured
      end
      update_attributes(x_coordinate: new_x, y_coordinate: new_y)
    else
      return false
    end
  end

  def mark_as_captured
    update_attributes(x_coordinate: nil, y_coordinate: nil)
  end

  private


  def valid_move?(x,y)
    # check if x is equal to the piece x postion if so it didn't move in x as well as check y
      x != x_coordinate && y != y_coordinate &&
      (x < BOARD_SIZE || x >= 0) || (y < BOARD_SIZE || y >= 0)

  end

  def in_bound?(x, y)
    (x < BOARD_SIZE || x >= 0) || (y < BOARD_SIZE || y >= 0)

  end

  def capturing_move?(x,y)
    Piece
      .where(x_coordinate: x, y_coordinate: y)
      .where.not(piece_color: piece_color)
      .exists?
  end


end


