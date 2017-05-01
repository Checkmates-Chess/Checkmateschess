class Pawn < Piece
  def valid_move?(end_vertical, end_horizontal)
    start_row = y_coordinate.to_i
    start_col = x_coordinate.to_i
    end_vertical = end_vertical.to_i
    end_horizontal = end_horizontal.to_i
    possible_squares = []

    # forward moves
    if piece_color == "black" && start_row + 1 < 8
      possible_squares << [start_col, start_row + 1]
    elsif piece_color == "white" && start_row - 1 >= 0
      possible_squares << [start_col, start_row - 1]
    end

    if piece_status.include?("first move")
      if piece_color == "black" && start_row + 2 < 8
        if !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row + 1)
          possible_squares << [start_col, start_row + 2]
        end
      elsif piece_color == "white" && start_row - 2 >= 0
        if !game.pieces.exists?(x_coordinate: start_col, y_coordinate: start_row - 1)
          possible_squares << [start_col, start_row - 2]
        end
      end
    end

    if possible_squares.include?([end_horizontal, end_vertical])
      return super
    end
    can_capture?(end_vertical, end_horizontal) && super
  end

  def can_capture?(end_vertical, end_horizontal)
    start_row = y_coordinate.to_i
    start_col = x_coordinate.to_i
    end_vertical = end_vertical.to_i
    end_horizontal = end_horizontal.to_i
    possible_squares = []

    # diagonal capture
    if piece_color == "black" && start_row + 1 < 8 && start_col - 1 >= 0 && start_col + 1 < 8
      if game.pieces.exists?(x_coordinate: start_col - 1, y_coordinate: start_row + 1)
        if game.pieces.where(x_coordinate: start_col - 1, y_coordinate: start_row + 1).first.piece_color == "white"
          possible_squares << [start_col - 1, start_row + 1]
        end
      end
      if game.pieces.exists?(x_coordinate: start_col + 1, y_coordinate: start_row + 1)
        if game.pieces.where(x_coordinate: start_col + 1, y_coordinate: start_row + 1).first.piece_color == "white"
          possible_squares << [start_col + 1, start_row + 1]
        end
      end

    elsif piece_color == "white" && start_row - 1 >= 0 && start_col - 1 >= 0 && start_col + 1 < 8
      if game.pieces.exists?(x_coordinate: start_col - 1, y_coordinate: start_row - 1)
        if game.pieces.where(x_coordinate: start_col - 1, y_coordinate: start_row - 1).first.piece_color == "black"
          possible_squares << [start_col - 1, start_row - 1]
        end
      end
      if game.pieces.exists?(x_coordinate: start_col + 1, y_coordinate: start_row - 1)
        if game.pieces.where(x_coordinate: start_col + 1, y_coordinate: start_row - 1).first.piece_color == "black"
          possible_squares << [start_col + 1, start_row - 1]
        end
      end
    end

    if possible_squares.include?([end_horizontal, end_vertical])
      return true
    end
    false
  end
end
