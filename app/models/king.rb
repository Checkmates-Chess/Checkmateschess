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
    return false unless piece_status.include?("first move")

    # # Make sure king hasn't moved
    # return false unless piece_status.include?("first move") 

    # # Make sure only moving horizontally from home row
    if piece_color == "black"
      return false unless y_coordinate == 0 && new_y == 0
    elsif piece_color == "white"
      return false unless y_coordinate == 7 && new_y == 7
    end

    # Store rooks into variables



    #  Determines if on King Side
    if new_x == 6
      @king_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 7, y_coordinate: y_coordinate, piece_status: "alive|first move")
      return false unless !@king_side_rook.nil?
      @kings_new_x = 6
      @rooks_new_x = 5
      return true
    end

    #  Determines if on Queen Side
    if new_x == 2
      @queen_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 0, y_coordinate: y_coordinate, piece_status: "alive|first move")
      return false unless !@queen_side_rook.nil?
      @kings_new_x = 2
      @rooks_new_x = 3
      return true
    end

  end

  def castle_move!(new_y, new_x)
    if new_x == 6
      @king_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 7, piece_color: piece_color)

      update_attributes(x_coordinate: 6, piece_status: "alive")
      @king_side_rook.update_attributes(x_coordinate: 5, piece_status: "alive")
    elsif new_x == 2
      @queen_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 0, piece_color: piece_color)

      update_attributes(x_coordinate: 2, piece_status: "alive")
      @queen_side_rook.update_attributes(x_coordinate: 3, piece_status: "alive")
    end
    return true
  end

end
