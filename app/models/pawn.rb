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
    if can_capture?(end_vertical, end_horizontal)
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

  def can_promote(y)
    y == 7 && self.piece_color == "white" || y == 0 && self.piece_color == "black"
    # if y == 7 && self.piece_color == "white"
    #   return true
    # end
    # if y == 0 && self.piece_color == "black"
    #   return true
    # end
  end

  # def promotion(params)
  #
  #   x = params[:x_coordinate].to_i
  #   y = params[:y_coordinate].to_i
  #   type = params[:piece_type]
  #   color = params[:piece_color]
  #
  #   update_attributes(x_position: nil,y_position: nil)
  #
  #   game.pieces.create(
  #     x_coordinate: x,
  #     y_coordinate: y,
  #     piece_type: type,
  #     piece_color: color,
  #     player_id: player_id
  #     )
  # end

  def promotion(piece, type)
    piece.update_attributes(piece_type: type)
    return piece
  end

end
