class King < Piece
  def valid_move?(new_x, new_y)
    ((new_x - x_coordinate).abs <= 1 && (new_y - y_coordinate).abs <= 1 )&& super(new_x, new_y)
  end







  def move_out_of_check?
    starting_x = x_coordinate
    starting_y = y_coordinate

    # still in check
    success = false
    ((x_coordinate-1)..(x_coordinate+1)).each do |x|
      ((y_coordinate-1)..(y_coordinate+1)).each do |y|

        # check if that square is available
        # self.x_coordinate = x
        # self.y_coordinate = y
        self.update_attributes(x_coordinate:x, y_coordinate: y) if self.valid_move?(x,y)
        return success = true if self.game.side_in_check?(self.piece_color) == false

        #reset the king to redo moves
        self.update_attributes(x_coordinate: starting_x, y_coordinate: starting_y)
      end
    end
    success
  end




end
