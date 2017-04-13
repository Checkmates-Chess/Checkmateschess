class Rook < Piece
  
  def valid_move?(board, start_y, start_x, new_y, new_x)
  	if starty_x == new_x || start_y == new_y && super
  		true
  	else
  		false
  	end
end