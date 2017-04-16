class Pawn < Piece

  def valid_move?(end_vertical, end_horizontal)
    start_row = y_coordinate
    start_col = x_coordinate
    end_row = end_vertical
    end_col = end_horizontal

    board = [[], [], [], [], [], [], [], []]

    i = 0
    while i < 8
      j = 0
      while j < 8
        if game.pieces.exists?(x_coordinate: i, y_coordinate: j)
          board[j][i] = game.pieces.where(x_coordinate: i, y_coordinate: j).first
        else
          board[j][i] = "open space"
        end
        j += 1
      end
      i += 1
    end

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

    if possible_squares.include?([end_horizontal, end_vertical])
      #return true && super
      return super && true
    end
    false
  end

end
