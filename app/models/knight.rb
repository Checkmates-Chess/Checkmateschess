class Knight < Piece

  private

  def valid_move?(x, y)
     # x, y
     # x_coordinate, y_corrdinate
     #
     # (2,1) up right, (2,-1) up left, (1,2), [-2,-1,1,2]
     diff_x = (x - x_coordinate).abs
     diff_y = (y - y_coordinate).abs
     super(x, y) && (diff_x == 2 && diff_y == 1) || (diff_x == 1 && diff_y == 2)


  end
end
