class King < Piece
  def valid_move?(new_x, new_y)
    (new_x - x_coordinate).abs <= 1 && (new_y - y_coordinate).abs <= 1 && super
  end






  def move_out_of_check?
    starting_x = x_coordinate
    starting_y = y_coordinate

    # still in check
    success = false
    ((x_coordinate-1)..(x_coordinate+1)).each do |x|
      ((y_coordinate-1).. (y_coordinate+1)).each do |y|

        # check if that square is available
        self.update_attributes(x_coordinate:x, y_coordinate: y) if valid_move?(x,y)
        success = true if game.in_check?(piece_color) == false

        #reset the king to redo moves
        self.update_attributes(x_coordinate: starting_x, y_coordinate: starting_y)
      end
    end
    success
  end




end
