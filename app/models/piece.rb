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


  # for testing only until valid move for general piece is on master branch
  def valid_move?(board, end_point)
    piece_status = self.piece_status
    piece_color = self.piece_color
    start_point = [self.x_coordinate, self.y_coordinate]
    start_row = start_point[1] 
    start_col = start_point[0]
    end_row = end_point[1]
    end_col = end_point[0]

    if start_row > 7 || start_row < 0 || start_col > 7 || start_col < 0 || 
      end_row > 7 || end_row < 0 || end_col > 7 || end_col < 0
      return false
    end
    piece_color = piece_color.downcase
    piece_status = piece_status.downcase
    possible_squares = []

    # forward moves
    if piece_color == "black" && start_row + 1 < 8
      if !is_obstructed?(board, start_row, start_col, start_row + 1, start_col)
        possible_squares << [start_col, start_row + 1]
      end
    elsif piece_color == "white" && start_row - 1 >= 0
      if !is_obstructed?(board, start_row, start_col, start_row - 1, start_col)
        possible_squares << [start_col, start_row - 1]
      end
    end

    if piece_status.include?("first move")
      if piece_color == "black" && start_row + 2 < 8
        if !is_obstructed?(board, start_row, start_col, start_row + 2, start_col)
          possible_squares << [start_col, start_row + 2]
        end
      elsif piece_color == "white" && start_row - 2 >= 0
        if !is_obstructed?(board, start_row, start_col, start_row - 2, start_col)
          possible_squares << [start_col, start_row - 2]
        end
      end
    end

    # diagonal capture
    if piece_color == "black" && start_row + 1 < 8 && start_col - 1 >= 0 && start_col + 1 < 8
      if is_obstructed?(board, start_row, start_col, start_row + 1, start_col - 1)
        if board[start_row + 1][start_col - 1].piece_color == "white"
          possible_squares << [start_col - 1, start_row + 1]
        end
      end
      if is_obstructed?(board, start_row, start_col, start_row + 1, start_col + 1)
        if board[start_row + 1][start_col + 1].piece_color == "white"
          possible_squares << [start_col + 1, start_row + 1]
        end
      end

    elsif piece_color == "white" && start_row - 1 >= 0 && start_col - 1 >= 0 && start_col + 1 < 8
      if is_obstructed?(board, start_row, start_col, start_row - 1, start_col - 1)
        if board[start_row - 1][start_col - 1].piece_color == "black"
          possible_squares << [start_col - 1, start_row - 1]
        end
      end
      if is_obstructed?(board, start_row, start_col, start_row - 1, start_col + 1)
        if board[start_row - 1][start_col + 1].piece_color == "black"
          possible_squares << [start_col + 1, start_row - 1]
        end
      end
    end

    if possible_squares.include?(end_point)
      #return true && super
      return true
    end
    false
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

