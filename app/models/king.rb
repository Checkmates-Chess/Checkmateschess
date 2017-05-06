class King < Piece
  def valid_move?(new_y, new_x)
    # return true if super AND legal_move? or castle_valid_move?
    (normal_move?(new_y, new_x) || castle_valid_move?(new_y, new_x)) && super
  end

  # Checks for typical King Moves
  def normal_move?(new_y, new_x)
    (new_x.to_i - x_coordinate.to_i).abs <= 1 && (new_y.to_i - y_coordinate.to_i).abs <= 1
  end

  # Checks for Castling Moves
  def castle_valid_move?(new_y, new_x)
    # Ending on the appropriate square
    return false unless (new_x.to_i == 2 || new_x.to_i == 6) 

    # Make sure king hasn't moved
    return false if y_coordinate_changed? 
    return false if x_coordinate_changed?

    # Make sure only moving horizontally from home row
    if self.piece_color == "black"
      return false unless y_coordinate == 0 && new_y == 0
    elsif self.piece_color == "white"
      return false unless y_coordinate == 7 && new_y == 7
    end

    # Store rooks into variables
    @queen_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 0, piece_color: piece_color)
    @king_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 7, piece_color: piece_color)
    # Verify Rooks never moved
    return false unless (!@queen_side_rook.x_coordinate_changed? || !@king_side_rook.x_coordinate_changed?)
    return false unless (!@queen_side_rook.y_coordinate_changed? || !@king_side_rook.y_coordinate_changed?)


    #  Determine if on King Side
    # if new_x == 6 && !@king_side_rook.x_coordinate_changed?
    if new_x == 6 && !@king_side_rook.x_coordinate_changed?
      @kings_new_x = 6
      @rooks_new_x = 5
      castle_move!
      return true
    end

    #  Determines if on Queen Side
    if new_x == 2 && !@queen_side_rook.x_coordinate_changed?
      @kings_new_x = 2
      @rooks_new_x = 3
      castle_move!
      return true
    end

  end

  # Actually Moves the Pieces
  def castle_move!
    update_attributes(x_coordinate: @kings_new_x)
    if @kings_new_x == 6
      @king_side_rook.update_attributes(x_coordinate: @rooks_new_x)
    elsif @kings_new_x == 2
      @queen_side_rook.update_attributes(x_coordinate: @rooks_new_x)
    end
  end

end
