module GamesHelper

  def find_piece(row, col)
    if row == 1
      image_tag("black-pawn.svg", class: "pieces") 
    elsif row == 0 && (col == 0 || col == 7)
      image_tag("black-rook.svg", class: "pieces") 
    elsif row == 0 && (col == 1 || col == 6)
      image_tag("black-knight.svg", class: "pieces") 
    elsif row == 0 && (col == 2 || col == 5)
      image_tag("black-bishop.svg", class: "pieces") 
    elsif row == 0 && col == 4
      image_tag("black-queen.svg", class: "pieces") 
    elsif row == 0 && col == 3
      image_tag("black-king.svg", class: "pieces") 
    elsif row == 6
      image_tag("white-pawn.svg", class: "pieces") 
    elsif row == 7 && (col == 0 || col == 7)
      image_tag("white-rook.svg", class: "pieces") 
    elsif row == 7 && (col == 1 || col == 6)
      image_tag("white-knight.svg", class: "pieces") 
    elsif row == 7 && (col == 2 || col == 5)
      image_tag("white-bishop.svg", class: "pieces") 
    elsif row == 7 && col == 4
      image_tag("white-queen.svg", class: "pieces") 
    elsif row == 7 && col == 3
      image_tag("white-king.svg", class: "pieces") 
    end
  end

end
