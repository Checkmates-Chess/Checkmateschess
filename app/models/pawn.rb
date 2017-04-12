class Pawn < Piece

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
      if board[start_row + 1][start_col - 1] != "open space"
        if board[start_row + 1][start_col - 1].piece_color == "white"
          possible_squares << [start_col - 1, start_row + 1]
        end
      end
      if board[start_row + 1][start_col + 1] != "open space"
        if board[start_row + 1][start_col + 1].piece_color == "white"
          possible_squares << [start_col + 1, start_row + 1]
        end
      end

    elsif piece_color == "white" && start_row - 1 >= 0 && start_col - 1 >= 0 && start_col + 1 < 8
      if board[start_row - 1][start_col - 1] != "open space"
        if board[start_row - 1][start_col - 1].piece_color == "black"
          possible_squares << [start_col - 1, start_row - 1]
        end
      end
      if board[start_row - 1][start_col + 1] != "open space"
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

end
