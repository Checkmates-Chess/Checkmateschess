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
    return false unless (new_x.to_i == 2 || new_x.to_i == 6) 
    return false unless piece_status.include?("first move")

    # # Make sure king hasn't moved
    # return false unless piece_status.include?("first move") 

    # # Make sure only moving horizontally from home row
    if piece_color == "black"
      return false unless y_coordinate.to_i == 0 && new_y.to_i == 0
    elsif piece_color == "white"
      return false unless y_coordinate.to_i == 7 && new_y.to_i == 7
    end

    #  Determines if on King Side
    if new_x.to_i == 6
      @king_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 7, y_coordinate: y_coordinate, piece_status: "alive|first move")
      return false unless !@king_side_rook.nil?
 
      return true
    #  Determines if on Queen Side
    elsif new_x.to_i == 2
      @queen_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 0, y_coordinate: y_coordinate, piece_status: "alive|first move")
      return false unless !@queen_side_rook.nil?
 
      return true
    else
      return false
    end
 
  end

  def castle_move!(new_y, new_x)
    if new_x.to_i == 6
      @king_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 7, piece_color: piece_color)

      update_attributes(x_coordinate: 6, piece_status: "alive|castle move")
      @king_side_rook.update_attributes(x_coordinate: 5, piece_status: "alive|castle move")
    elsif new_x.to_i == 2
      @queen_side_rook = game.pieces.find_by(piece_type: "Rook", x_coordinate: 0, piece_color: piece_color)

      update_attributes(x_coordinate: 2, piece_status: "alive")
      @queen_side_rook.update_attributes(x_coordinate: 3, piece_status: "alive")
    end
    return true
  end

  def has_valid_move?
    8.times do |row|
      8.times do |col|
        if valid_move?(row, col)
          return true
        end
      end
    end
    false
  end

  def can_be_captured?
    opponents = self.games.where.not(piece_color: self.piece_color).all
    opponents.each do |opponent|
     if opponent.valid_move?(self.x_coordinate, self.y_coordinate)
       #We can capture the piece
       return true
     end
    end
    return false
  end

end
