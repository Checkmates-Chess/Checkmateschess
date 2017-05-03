class Knight < Piece
  def valid_move?(y, x)
    # check valid move from piece.rb and check if x and y of knight is valid
    diff_x = x.to_i - x_coordinate.to_i
    diff_x_abs = diff_x.abs
    diff_y = y.to_i - y_coordinate.to_i
    diff_y_abs = diff_y.abs
    if (diff_x_abs == 2 && diff_y_abs == 1) || (diff_x_abs == 1 && diff_y_abs == 2)
        return super
    end
    false
  end
end