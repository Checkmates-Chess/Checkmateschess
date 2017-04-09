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


#This method is important and eventually, we will use it in the controller to handle moving pieces.

#This move_to method should handle the following cases:

#check to see if there is a peice in the location

#If there is a piece occupying the location, and it is the opposite color, remove the piece from the chess board

#This can be done a few different ways.
#You could have a “status” flag on the piece that will be one of “onboard” or “captured”.
#You could set the piece’s x/y coordinates to nil
#You could delete the item from the database.

#If the piece is there and it’s the same color the move should fail - it should either raise an error message or do nothing.
#It should call update_attributes on the piece and change the piece’s x/y position.
#Note: This method does not check if a move is valid. We will be using the valid_move? method to do that.


  # MY ATTEMPT

  def move_to!(new_x, new_y)
    if valid_move?(new_x, new_y)
      if capturing_move?(new_x, new_y)
        # mark captured piece as captured
        piece = Piece.where(x_coordinate:x, y_coordinate: y).last
        piece.mark_as_captured
      end
      update_attributes(x_position: new_x, y_position: new_y)
    else
      return false
    end
  end

  def mark_as_captured
    update_attributes(x_coordinate: nil, y_coordinate: nil)
  end

  private

# 8 x 8, x : [0,7]
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
      .exits?
  end


end



  # def move_to!(new_x, new_y)
  #   if valid_move?(new_x, new_y)
  #     if capturing_move?(new_x, new_y)
  #       # mark captured piece as captured
  #     end
  #     update(x_position: new_x, y_position: new_y)
  #   else
  #     return false
  #   end
  # end


