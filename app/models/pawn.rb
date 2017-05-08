class Pawn < Piece
  def valid_move?(end_vertical, end_horizontal)
    start_row = y_coordinate.to_i
    start_col = x_coordinate.to_i
    end_vertical = end_vertical.to_i
    end_horizontal = end_horizontal.to_i
    possible_squares = []

    # checks diagonal capture
    if can_capture?(end_vertical, end_horizontal)
      return super
    end

    # forward moves
    if piece_color == "black" && start_row + 1 < 8
      if !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row + 1)
        possible_squares << [start_col, start_row + 1]
      end
    elsif piece_color == "white" && start_row - 1 >= 0
      if !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row - 1)
        possible_squares << [start_col, start_row - 1]
      end
    end

    if piece_status.include?("first move")
      if piece_color == "black" && start_row + 2 < 8
        if !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row + 1) &&
          !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row + 2)
          possible_squares << [start_col, start_row + 2]
        end
      elsif piece_color == "white" && start_row - 2 >= 0
        if !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row - 1) &&
          !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row - 2)
          possible_squares << [start_col, start_row - 2]
        end
      end
    end

    if possible_squares.include?([end_horizontal, end_vertical])
      return super
    end
    false
  end

  def can_capture?(end_vertical, end_horizontal)
    start_row = y_coordinate.to_i
    start_col = x_coordinate.to_i
    end_vertical = end_vertical.to_i
    end_horizontal = end_horizontal.to_i
    possible_squares = []

    # diagonal capture
    if piece_color == "black" 
      if start_row + 1 < 8 && start_col - 1 >= 0
        if game.pieces.exists?(x_coordinate: start_col - 1, y_coordinate: start_row + 1, piece_color: "white")
          possible_squares << [start_col - 1, start_row + 1]
        end
      end
      if start_row + 1 < 8 && start_col + 1 >= 0
        if game.pieces.exists?(x_coordinate: start_col + 1, y_coordinate: start_row + 1, piece_color: "white")
          possible_squares << [start_col + 1, start_row + 1]
        end
      end

    elsif piece_color == "white" 
      if start_row - 1 >= 0 && start_col - 1 >= 0 
        if game.pieces.exists?(x_coordinate: start_col - 1, y_coordinate: start_row - 1, piece_color: "black")
          possible_squares << [start_col - 1, start_row - 1]
        end
      end
      if start_row - 1 >= 0 && start_col + 1 >= 0 
        if game.pieces.exists?(x_coordinate: start_col + 1, y_coordinate: start_row - 1, piece_color: "black")
          possible_squares << [start_col + 1, start_row - 1]
        end
      end
    end

    if possible_squares.include?([end_horizontal, end_vertical])
      return true
    end
    false
  end

  def move_to!(new_y, new_x)
    remove_flag = false
    if piece_status.include?("first move")
      piece_status.sub! "|first move", ""
      update_attributes(piece_status: piece_status)
    end
    if can_capture?(new_y, new_x)
      remove_flag = true
      captured_piece = game.pieces.where(x_coordinate: new_x, y_coordinate: new_y).first
      captured_piece_status = captured_piece.piece_status
      captured_piece_status.sub! "alive", "captured"
      captured_piece.update_attributes(x_coordinate: nil, y_coordinate: nil, piece_status: captured_piece_status)
      update_attributes(x_coordinate: new_x, y_coordinate: new_y)
    else
      update_attributes(x_coordinate: new_x, y_coordinate: new_y)
    end
    return remove_flag
  end

  def has_valid_move?
    8.times do |row|
      8.times do |col|
        if valid_move?(row, col)
          return true
        end
      end
    end
    false
  end
end
