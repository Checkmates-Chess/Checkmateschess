class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  #attr_accessor :game_id, :piece_type, :piece_color, :piece_status, :x_coordinate, :y_coordinate

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
        piece = Piece.where(x_coordinate:new_x, y_coordinate: new_y).last
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



  def valid_move?(x,y)
    # check if x is equal to the piece x postion if so it didn't move in x as well as check y
    x != x_coordinate && y != y_coordinate &&
      ((x < BOARD_SIZE || x >= 0) || (y < BOARD_SIZE || y >= 0))

  end

  def in_bound?(x, y)
    (x < BOARD_SIZE || x >= 0) || (y < BOARD_SIZE || y >= 0)

  end

  def capturing_move?(x,y)
    piece = Piece.where(x_coordinate: x, y_coordinate: y).where.not(piece_color: piece_color).exists?
    return piece
  end

  def can_be_captured?
    opponents = self.games.where.not(piece_color: self.piece_color).all
    opponents.each do |opponent|
      if opponent.valid_move?(self.x_coordinate, self.y_coordinate)
        #We can capture the piece
        return true
      end
    end
    return false
  end












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
      elsif board[check_vertical][check_horizontal] != "open space"
        return true
      end
    end
  end

end


