class King < Piece
  def valid_move?(new_y, new_x)
    (new_x - x_coordinate).abs <= 1 && (new_y - y_coordinate).abs <= 1 && super
  end
end
