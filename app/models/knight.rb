class Knight < Piece
  def valid_move?(y, x)
    # check valid move from piece.rb and check if x and y of knight is valid
    diff_x = x - x_coordinate
    diff_x_abs = diff_x.abs
    diff_y = y - y_coordinate
    if piece_color == "black"
      return super && ((diff_x_abs == 2 && diff_y == 1) || (diff_x_abs == 1 && diff_y == 2))
    else 
      return super && ((diff_x_abs == 2 && diff_y == -1) || (diff_x_abs == 1 && diff_y == -2))
    end
  end
end