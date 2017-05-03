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

  def move_to!(new_y, new_x)
    remove_flag = false
    if piece_status.include?("first move")
      piece_status.sub! "|first move", ""
      update_attributes(piece_status: piece_status)
    end
    if capturing_move?(new_y, new_x)
      remove_flag = true
      captured_piece = game.pieces.where(x_coordinate: new_x, y_coordinate: new_y).first
      captured_piece_status = captured_piece.piece_status
      if captured_piece_status.include?("alive")
        captured_piece_status.sub! "alive", "dead"
      end
      captured_piece.update_attributes(x_coordinate: nil, y_coordinate: nil, piece_status: captured_piece_status)
      update_attributes(x_coordinate: new_x, y_coordinate: new_y)
    else
      update_attributes(x_coordinate: new_x, y_coordinate: new_y)
    end
    return remove_flag
  end

  #used in valid_move?
  def friendly_on_endpoint?(end_y, end_x) 
    game.pieces.where(x_coordinate: end_x, y_coordinate: end_y, piece_color: piece_color).exists?
  end

  #used in move_to!
  def capturing_move?(end_y, end_x)
    enemy_color = piece_color == "white" ? "black" : "white"
    game.pieces.where(x_coordinate: end_x, y_coordinate: end_y, piece_color: enemy_color).exists?
  end

  # checks if a move is obstructed on horizontal, vertical, and 4 diagonal planes.
  # expects open spaces on the board to have the string "open space"
  def is_obstructed?(board, start_vertical,start_horizontal,end_vertical,end_horizontal)
    start_vertical = start_vertical.to_i
    start_horizontal = start_horizontal.to_i
    end_vertical = end_vertical.to_i
    end_horizontal = end_horizontal.to_i
  
    if start_vertical == end_vertical && start_horizontal == end_horizontal
      return true
    end
    # raises error if invalid move, otherwise runs
    if start_vertical == end_vertical || start_horizontal == end_horizontal    
      move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal)
    elsif ((start_vertical-end_vertical).abs != (start_horizontal - end_horizontal).abs)
      raise 'Invalid Input, not a diagonal horizontal or vertical move'
    else move_by_one(board, start_vertical, start_horizontal, end_vertical, end_horizontal)
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
    hor_incr = get_incr(start_horizontal, end_horizontal)
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

  def valid_move?(new_y, new_x)
    new_y = new_y.to_i 
    new_x = new_x.to_i

    # check if it's the piece's color's turn
    if piece_color != game.player_turn
      return false
    end

    # Checks if piece is within board coordinates
    if (new_x <= 7 && new_x >= 0) && (new_y <= 7 && new_y >= 0)
      # If new space is within board, check if there are obstructions.
      # If there is an obstruction, return false -- not a valid move. 
      # If there are no obstructions, return true -- is a valid move.

      board = [[], [], [], [], [], [], [], []]
      8.times do |row|
        8.times do |col|
          board_piece = game.pieces.where(x_coordinate: col, y_coordinate: row).first
          board[row][col] = board_piece
        end
      end
      if ((y_coordinate.to_i-new_y).abs == (x_coordinate.to_i-new_x).abs) ||
        y_coordinate.to_i == new_y || x_coordinate.to_i == new_x
        if is_obstructed?(board, y_coordinate, x_coordinate, new_y, new_x)
          return false
        end
      end
      if friendly_on_endpoint?(new_y, new_x)
        return false
      else
        return true
      end
    # If piece is not within board, it returns false -- not a valid move 
    else
      return false
    end 
  end

  def pawn_promotion?(new_y, new_x)
    if piece_type == "Pawn"
      if (piece_color == "white" && new_y == 0) ||
        (piece_color == "black" && new_y == 7)
        return true
      end
    end 
    false
  end

end

