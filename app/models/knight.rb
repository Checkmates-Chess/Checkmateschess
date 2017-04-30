class Knight < Piece
  def valid_move?(y, x)
     # check valid move from piece.rb and check if x and y of knight is valid
     diff_x = (x - x_coordinate).abs
     diff_y = (y - y_coordinate).abs
     super && ((diff_x == 2 && diff_y == 1) || (diff_x == 1 && diff_y == 2))
  end
end