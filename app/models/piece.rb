class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user
  attr_accessor :game_id, :piece_type, :piece_color, :piece_status, :x_coordinate, :y_coordinate

# the variable definitions and board was used to write the method.  once tests are implemented and we develop a board,
# we will possibly need to change board and o = "open space" variable and how it checks
# for open space.
# Then we can delete this.

# K = "black-king"
# Q = "black-queen"
# P = "black-pawn"
# R = "black-roke"
# N = "black-knight"
# B = "black-bishop"
# WK = "white-king"
# WQ = "white-queen"
# WP = "white-pawn"
# WR = "white-roke"
# WN = "white-knight"
# WB = "white-bishop"
# o = "open space"


# board = [
#   [R,N,B,K,Q,B,N,R],
#   [P,P,P,P,P,P,P,P],
#   [o,o,o,o,o,o,o,o],
#   [o,o,o,"start",o,o,o,3],
#   [o,o,o,o,o,o,o,"end"],
#   [o,o,o,o,o,o,o,o],
#   [WP,WP,WP,WP,WP,WP,WP,WP],
#   [WR,WN,WB,WK,WQ,WB,WN,WR]
#   ]

  # checks for obstruction using a board state, start and
  # end locations, and any open spaces being designated
  # "open space".  
  # possibly need to edit variables depending on end state of inputs

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
      end
      if board[check_vertical][check_horizontal] != "open space"
        return true
      end
    end
  end
end

