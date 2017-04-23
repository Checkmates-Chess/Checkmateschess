class Game < ApplicationRecord
  has_many :pieces
  belongs_to :user
  attr_accessor :board

  validates :game_title, presence: true, length: { minimum: 3, 
    maximum: 30 }

    # automatically populates game after one is created
    after_create do
        self.populate_game
    end

  # creates pieces and the @board variable 
  def populate_game
    @b_rook1 = Piece.create :game_id => id, :piece_type => "Rook", :piece_name => "b_rook1", :piece_color => "black", :piece_status => "alive", :x_coordinate => 0, :y_coordinate => 0
    @b_knight1 = Piece.create :game_id => id, :piece_type => "Knight", :piece_name => "b_knight1", :piece_color => "black", :piece_status => "alive", :x_coordinate => 1, :y_coordinate => 0
    @b_bishop1 = Piece.create :game_id => id, :piece_type => "Bishop", :piece_name => "b_bishop1", :piece_color => "black", :piece_status => "alive", :x_coordinate => 2, :y_coordinate => 0
    @b_king = Piece.create :game_id => id, :piece_type => "King", :piece_name => "b_king", :piece_color => "black", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 0
    @b_queen = Piece.create :game_id => id, :piece_type => "Queen", :piece_name => "b_queen", :piece_color => "black", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 0
    #@b_king = Piece.create :game_id => id, :piece_type => "King", :piece_name => "b_king", :piece_color => "black", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 0
    #@b_queen = Piece.create :game_id => id, :piece_type => "Queen", :piece_name => "b_queen", :piece_color => "black", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 0
    @b_bishop2 = Piece.create :game_id => id, :piece_type => "Bishop", :piece_name => "b_bishop2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 5, :y_coordinate => 0
    @b_knight2 = Piece.create :game_id => id, :piece_type => "Knight", :piece_name => "b_knight2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 6, :y_coordinate => 0
    @b_rook2 = Piece.create :game_id => id, :piece_type => "Rook", :piece_name => "b_rook2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 7, :y_coordinate => 0
    #@b_rook2 = Piece.create :game_id => id, :piece_type => "Rook", :piece_name => "b_rook2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 0, :y_coordinate => 1
    @b_pawn1 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn1", :piece_color => "black", :piece_status => "alive", :x_coordinate => 1, :y_coordinate => 1
    @b_pawn2 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 2, :y_coordinate => 1
    @b_pawn3 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn3", :piece_color => "black", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 1
    @b_pawn4 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn4", :piece_color => "black", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 1
    @b_pawn5 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn5", :piece_color => "black", :piece_status => "alive", :x_coordinate => 5, :y_coordinate => 1
    @b_pawn6 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn6", :piece_color => "black", :piece_status => "alive", :x_coordinate => 6, :y_coordinate => 1
    @b_pawn7 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn7", :piece_color => "black", :piece_status => "alive", :x_coordinate => 7, :y_coordinate => 1
    @b_pawn8 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn8", :piece_color => "black", :piece_status => "alive", :x_coordinate => 0, :y_coordinate => 1
    #@b_pawn8 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn8", :piece_color => "black", :piece_status => "alive", :x_coordinate => 8, :y_coordinate => 1
    @w_rook1 = Piece.create :game_id => id, :piece_type => "Rook", :piece_name => "w_rook1", :piece_color => "white", :piece_status => "alive", :x_coordinate => 0, :y_coordinate => 7
    @w_knight1 = Piece.create :game_id => id, :piece_type => "Knight", :piece_name => "w_knight1", :piece_color => "white", :piece_status => "alive", :x_coordinate => 1, :y_coordinate => 7
    @w_bishop1 = Piece.create :game_id => id, :piece_type => "Bishop", :piece_name => "w_bishop1", :piece_color => "white", :piece_status => "alive", :x_coordinate => 2, :y_coordinate => 7
    @w_king = Piece.create :game_id => id, :piece_type => "King", :piece_name => "w_king", :piece_color => "white", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 7
    @w_queen = Piece.create :game_id => id, :piece_type => "Queen", :piece_name => "w_queen", :piece_color => "white", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 7
    #@w_king = Piece.create :game_id => id, :piece_type => "King", :piece_name => "w_king", :piece_color => "white", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 7
    #@w_queen = Piece.create :game_id => id, :piece_type => "Queen", :piece_name => "w_queen", :piece_color => "white", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 7
    @w_bishop2 = Piece.create :game_id => id, :piece_type => "Bishop", :piece_name => "w_bishop2", :piece_color => "white", :piece_status => "alive", :x_coordinate => 5, :y_coordinate => 7
    @w_knight2 = Piece.create :game_id => id, :piece_type => "Knight", :piece_name => "w_knight2", :piece_color => "white", :piece_status => "alive", :x_coordinate => 6, :y_coordinate => 7
    @w_rook2 = Piece.create :game_id => id, :piece_type => "Rook", :piece_name => "w_rook2", :piece_color => "white", :piece_status => "alive", :x_coordinate => 7, :y_coordinate => 7
    @w_pawn1 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn1", :piece_color => "white", :piece_status => "alive", :x_coordinate => 0, :y_coordinate => 6
    @w_pawn2 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn2", :piece_color => "white", :piece_status => "alive", :x_coordinate => 1, :y_coordinate => 6
    @w_pawn3 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn3", :piece_color => "white", :piece_status => "alive", :x_coordinate => 2, :y_coordinate => 6
    @w_pawn4 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn4", :piece_color => "white", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 6
    @w_pawn5 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn5", :piece_color => "white", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 6
    @w_pawn6 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn6", :piece_color => "white", :piece_status => "alive", :x_coordinate => 5, :y_coordinate => 6
    @w_pawn7 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn7", :piece_color => "white", :piece_status => "alive", :x_coordinate => 6, :y_coordinate => 6
    @w_pawn8 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "w_pawn8", :piece_color => "white", :piece_status => "alive", :x_coordinate => 7, :y_coordinate => 6
    
    @board =  [
                #[@b_rook1, @b_knight1, @b_bishop1, @b_king, @b_queen, @b_bishop2, @b_knight2, @b_rook2],
                [@b_rook1, @b_knight1, @b_bishop1, @b_queen, @b_king, @b_bishop2, @b_knight2, @b_rook2],
                [@b_pawn8, @b_pawn1, @b_pawn2, @b_pawn3, @b_pawn4, @b_pawn5, @b_pawn6, @b_pawn7],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [@w_pawn1, @w_pawn2, @w_pawn3, @w_pawn4, @w_pawn5, @w_pawn6, @w_pawn7, @w_pawn8],
                [@w_rook1, @w_knight1, @w_bishop1, @w_queen, @w_king, @w_bishop2, @w_knight2, @w_rook2]
                #[@w_rook1, @w_knight1, @w_bishop1, @w_king, @w_queen, @w_bishop2, @w_knight2, @w_rook2],
              ]
  end

  def in_check?
    side_in_check?("black") || side_in_check?("white")
  end

  def side_in_check?(color)
    enemy = color == "white" ? "black" : "white"
    #white king in check
    #white_king = nil
    #white_king_row = nil
    #white_king_col = nil
    #pieces.each do |piece|
    #    puts "#{piece.piece_type} #{piece.piece_color} #{piece.y_coordinate} #{piece.x_coordinate}"
    #end
    if pieces.exists?(piece_type: "King", piece_color: color)
      king = pieces.where(piece_type: "King", piece_color: color).first
      #puts "king x #{king.x_coordinate} king y #{king.y_coordinate}"
      king_row = king.y_coordinate
      king_col = king.x_coordinate
      #puts "should be king"
      #puts "#{king.piece_type} #{king.piece_color} #{king.y_coordinate} #{king.x_coordinate}"
    end

    pieces.where(piece_color: enemy).each do |piece|
      #puts "should be non pawn"
      #puts "#{piece.piece_type} #{piece.piece_color} #{piece.y_coordinate} #{piece.x_coordinate}"  
      if piece.piece_type != "Pawn" && !piece.x_coordinate.nil? && !piece.y_coordinate.nil?
        if piece.valid_move?(king_row, king_col)
            #puts "can capture:"
            #puts "#{piece.piece_type} #{piece.piece_color} #{piece.y_coordinate} #{piece.x_coordinate}"  
            return true
        end
      end
    end
    
    #game.pieces.where(piece_type: "Bishop", piece_color: enemy).each do |bishop|
    #  if bishop.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Knight", piece_color: enemy).each do |knight|
    #  if knight.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Queen", piece_color: enemy).each do |queen|
    #  if queen.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "King", piece_color: enemy).each do |king|
    #  if king.valid_move?(white_king_row, white_king_col)
    #    return true
    #  end
    #end
    pieces.where(piece_type: "Pawn", piece_color: enemy).each do |pawn|
      #puts "should be pawn"
      #puts "#{pawn.piece_type} #{pawn.piece_color} #{pawn.y_coordinate} #{pawn.x_coordinate}"
      if !pawn.x_coordinate.nil? && !pawn.y_coordinate.nil?
        #puts "can capture:"
        #puts "#{pawn.piece_type} #{pawn.piece_color} #{pawn.y_coordinate} #{pawn.x_coordinate}"
        if pawn.can_capture?(king_row, king_col)
          return true
        end
      end
      #if pawn.y_coordinate + 1 == white_king_row && (pawn.x_coordinate - 1 == white_king_col || pawn.x_coordinate + 1 == white_king_col)
      #  return true
      #end
    end

    #black king in check
    #black_king = nil
    #black_king_row = nil
    #black_king_col = nil
    #if game.pieces.exists?(piece_type: "King", piece_color: "black")
    #  black_king = game.pieces.where(piece_type: "King", piece_color: "black").first
    #  black_king_row = black_king.y_coordinate
    #  black_king_col = black_king.x_coordinate
    #end

    #game.pieces.where(piece_type: "Rook", piece_color: "white").each do |rook|
    #  if rook.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Bishop", piece_color: "white").each do |bishop|
    #  if bishop.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Knight", piece_color: "white").each do |knight|
    #  if knight.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Queen", piece_color: "white").each do |queen|
    #  if queen.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "King", piece_color: "white").each do |king|
    #  if king.valid_move?(black_king_row, black_king_col)
    #    return true
    #  end
    #end
    #game.pieces.where(piece_type: "Pawn", piece_color: "white").each do |pawn|
    #  if pawn.y_coordinate - 1 == black_king_row && (pawn.x_coordinate - 1 == black_king_col || pawn.x_coordinate + 1 == black_king_col)
    #   return true
    #  end
    #end
    false
  end

end