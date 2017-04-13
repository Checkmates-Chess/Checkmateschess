class Bishop < Piece

  def valid_move?(new_x, new_y)
    (x_coordinate - new_x).abs == (y_coordinate - new_y).abs && super
  end

end