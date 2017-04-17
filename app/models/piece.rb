class Piece < ApplicationRecord
  belongs_to :game
  
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

  # checks if a move is obstructed on horizontal, vertical, and 4 diagonal planes.
  # if piece doesn't move raises an error, if piece is not on one of the above planes
  # expects open spaces on the board to have the string "open space"
  def is_obstructed?(board, start_vertical,start_horizontal,end_vertical,end_horizontal)
    # raises error if end position is same as starting
    raise 'Invalid Input, destination must be different from start' if start_vertical == end_vertical && start_horizontal == end_horizontal
    # raises error if invalid move, otherwise runs
    if start_vertical == end_vertical || start_horizontal == end_horizontal    
       move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal)
    elsif ((start_vertical-end_vertical).abs != (start_horizontal - end_horizontal).abs)
          raise 'Invalid Input, not a diagonal horizontal or vertical move'
    else  move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal)
    end
  end

  # figures out which direction on the board to iterate
  def get_incr(start_p, end_p)
      incr = end_p - start_p
      if incr != 0
      incr = incr / incr.abs
      end
      return incr
  end

  # iterates by one square in whichever direction we specify and checks for "open space"
  def move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal)
    check_vertical = start_vertical
    check_horizontal = start_horizontal
    vert_incr = get_incr(start_vertical, end_vertical)
    hor_incr= get_incr(start_horizontal, end_horizontal)
    while(check_vertical != end_vertical || 
      check_horizontal != end_horizontal)
      check_vertical += vert_incr
      check_horizontal += hor_incr
      if [[check_horizontal],[check_vertical]] === [[end_horizontal],[end_vertical]]
        return false
      elsif board[check_vertical][check_horizontal] != nil
        return true
      end
    end
  end
end

