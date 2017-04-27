module GamesHelper

  def place_pieces(row, col)     
    game = @game     
    piece = game.pieces.find_by_y_coordinate_and_x_coordinate(col, row)     
    if piece       
      image_tag("white-pawn.svg", class: "pieces")      
      #image_tag("#{piece.piece_name}.svg", class: "pieces")
    end   
  end

end
