class King < Piece
  def valid_move?(new_y, new_x)
    # return true if super AND (legal_move? or castle_valid_move?)
    (normal_move?(new_y, new_x) || castle_valid_move?(new_y, new_x)) && super
  end

  # Checks for typical King Moves
  def normal_move?(new_y, new_x)
    (new_x.to_i - x_coordinate.to_i).abs <= 1 && (new_y.to_i - y_coordinate.to_i).abs <= 1
  end

  # Checks for Castling Moves
  def castle_valid_move?(new_y, new_x)
    # Ending on the appropriate square
    return false unless (new_x == 2 || new_x == 6) 

    # # Make sure king hasn't moved
    # return false unless piece_status.include?("first move") 

    # # Make sure only moving horizontally from home row
    if piece_color == "black"
      return false unless y_coordinate == 0 && new_y == 0
    elsif piece_color == "white"
      return false unless y_coordinate == 7 && new_y == 7

    end

    # # Store rooks into variables
    # @queen_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 0, piece_color: piece_color, piece_status: "alive|first move")
    # @king_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 7, piece_color: piece_color, piece_status: "alive|first move")
    # # Verify Rooks never moved
    # return false unless !@queen_side_rook.nil?
    # return false unless !@king_side_rook.nil?

    #  Determines if on King Side
    if new_x == 6
      # return false if @king_side_rook.nil?
      @kings_new_x = 6
      @rooks_new_x = 5
      return castle_move!
    end

    #  Determines if on Queen Side
    if new_x == 2
      # return false if @queen_side_rook.nil?
      @kings_new_x = 2
      @rooks_new_x = 3
      return castle_move!
    end

  end

  # Actually Moves the Pieces
  def castle_move!
    if @kings_new_x == 6
      # @king_side_rook.update_attributes(x_coordinate: @rooks_new_x)
      return true
    elsif @kings_new_x == 2
      # @queen_side_rook.update_attributes(x_coordinate: @rooks_new_x)
      return true
    else return false
    end
  end

end
