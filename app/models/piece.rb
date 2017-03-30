class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user
# this was used to write.  once tests are implemented and we develop a board,
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
#   [o,o,o,3,o,o,o,o],
#   [o,o,o,o,o,o,o,o],
#   [o,o,o,o,o,o,o,o],
#   [WP,WP,WP,WP,WP,WP,WP,WP],
#   [WR,WN,WB,WK,WQ,WB,WN,WR]
#   ]
#   start_vertical = 3 
#   start_horizontal= 3
#   end_vertical = 5
#   end_horizontal = 4
#   puts board[start_vertical][start_horizontal]
#   puts board[end_vertical][end_horizontal]
 
  # checks for obstruction using a board state, start and
  # end locations, and any open spaces being designated
  # "open space"
  def is_obstructed?(board, start_vertical,start_horizontal,end_vertical,end_horizontal)
    # raises error if end position is same as starting
    raise 'Invalid Input, destination must be different from start' if start_vertical == end_vertical && start_horizontal == end_horizontal

    # need to raise an error if invalid move
    
    # should they all be elsif?
    # up/right
    if start_vertical > end_vertical && start_horizontal < end_horizontal
      return move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, -1, 1)
    # up/left
    elsif start_vertical > end_vertical && start_horizontal > end_horizontal
      return move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, -1, -1)
    # down/left
    elsif start_vertical < end_vertical && start_horizontal > end_horizontal
      return move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, 1, -1)
    # down/right
    elsif start_vertical < end_vertical && start_horizontal < end_horizontal
      return move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, 1, 1)
    end
    # up/down 
    if start_horizontal === end_horizontal
      if start_vertical < end_vertical
        move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, 1, 0)
      else
        move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, -1, 0)
      end
    # left/right
    elsif start_vertical === end_vertical
      if start_horizontal < end_horizontal
        move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, 0, 1)
      else
      move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, 0, -1)
      end
    end

  end
  
  # iterates by one square in whichever direction we specify and checks for "open space"
  # 
  def move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal, vert_incr, hor_incr)
    check_vertical = start_vertical
    check_horizontal = start_horizontal
    while(check_vertical != end_vertical || check_horizontal != end_horizontal)
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

 puts is_obstructed?(board, start_vertical ,start_horizontal, end_vertical, end_horizontal)
end
