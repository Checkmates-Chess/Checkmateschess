class King < Piece
  def valid_move?(new_y, new_x)
    if (new_x.to_i - x_coordinate.to_i).abs <= 1 && (new_y.to_i - y_coordinate.to_i).abs <= 1
      return super
    else
      return false
    end
  end
end