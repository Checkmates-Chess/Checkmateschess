class Queen < Piece
  def valid_move?(new_y, new_x)
    if (new_x - x_coordinate).abs == (new_y - y_coordinate).abs ||
      new_x == x_coordinate || new_y == y_coordinate
      return super
    else
      false
    end
  end
end