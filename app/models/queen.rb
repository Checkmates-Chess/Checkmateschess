class Queen < Piece
  def valid_move?(new_y, new_x)
    (new_x - x_coordinate).abs <= 7 && (new_y - y_coordinate).abs <= 7 && super
  end
end
