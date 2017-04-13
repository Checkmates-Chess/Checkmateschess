class Bishop < Piece

  def valid_move?(board, start_y, start_x, new_y, new_x)
    (x_coordinate - new_x).abs == (y_coordinate - new_y).abs && super
  end

end