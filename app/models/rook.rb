class Rook < Piece
  def valid_move?(new_y, new_x)
  	if (x_coordinate.to_i == new_x.to_i || y_coordinate.to_i == new_y.to_i) && super
  		true
  	else
  		false
  	end
  end
end