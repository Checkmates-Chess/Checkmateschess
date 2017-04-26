class Rook < Piece
  
  def valid_move?(new_y, new_x)
  	if x_coordinate == new_x || y_coordinate == new_y && super
  		true
  	else
  		false
  	end
  end
end