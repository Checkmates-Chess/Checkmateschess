class Queen < Piece
  def valid_move?(new_y, new_x)
    if (new_x.to_i - x_coordinate.to_i).abs == (new_y.to_i - y_coordinate.to_i).abs ||
      new_x.to_i == x_coordinate.to_i || new_y.to_i == y_coordinate.to_i
      return super
    else
      false
    end
  end
end
