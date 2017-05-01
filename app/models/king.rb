class King < Piece
  def valid_move?(new_y, new_x)
    (new_x.to_i - x_coordinate.to_i).abs <= 1 && (new_y.to_i - y_coordinate.to_i).abs <= 1 && super
  end
end