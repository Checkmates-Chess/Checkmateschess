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
    @b_king = Piece.create :game_id => id, :piece_type => "King", :piece_name => "b_king", :piece_color => "black", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 0
    @b_queen = Piece.create :game_id => id, :piece_type => "Queen", :piece_name => "b_queen", :piece_color => "black", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 0
    @b_bishop2 = Piece.create :game_id => id, :piece_type => "Bishop", :piece_name => "b_bishop2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 5, :y_coordinate => 0
    @b_knight2 = Piece.create :game_id => id, :piece_type => "Knight", :piece_name => "b_knight2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 6, :y_coordinate => 0
    @b_rook2 = Piece.create :game_id => id, :piece_type => "Rook", :piece_name => "b_rook2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 7, :y_coordinate => 0
    @b_pawn1 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn1", :piece_color => "black", :piece_status => "alive", :x_coordinate => 0, :y_coordinate => 1
    @b_pawn2 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn2", :piece_color => "black", :piece_status => "alive", :x_coordinate => 1, :y_coordinate => 1
    @b_pawn3 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn3", :piece_color => "black", :piece_status => "alive", :x_coordinate => 2, :y_coordinate => 1
    @b_pawn4 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn4", :piece_color => "black", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 1
    @b_pawn5 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn5", :piece_color => "black", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 1
    @b_pawn6 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn6", :piece_color => "black", :piece_status => "alive", :x_coordinate => 5, :y_coordinate => 1
    @b_pawn7 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn7", :piece_color => "black", :piece_status => "alive", :x_coordinate => 6, :y_coordinate => 1
    @b_pawn8 = Piece.create :game_id => id, :piece_type => "Pawn", :piece_name => "b_pawn8", :piece_color => "black", :piece_status => "alive", :x_coordinate => 7, :y_coordinate => 1
    @w_rook1 = Piece.create :game_id => id, :piece_type => "Rook", :piece_name => "w_rook1", :piece_color => "white", :piece_status => "alive", :x_coordinate => 0, :y_coordinate => 7
    @w_knight1 = Piece.create :game_id => id, :piece_type => "Knight", :piece_name => "w_knight1", :piece_color => "white", :piece_status => "alive", :x_coordinate => 1, :y_coordinate => 7
    @w_bishop1 = Piece.create :game_id => id, :piece_type => "Bishop", :piece_name => "w_bishop1", :piece_color => "white", :piece_status => "alive", :x_coordinate => 2, :y_coordinate => 7
    @w_king = Piece.create :game_id => id, :piece_type => "King", :piece_name => "w_king", :piece_color => "white", :piece_status => "alive", :x_coordinate => 3, :y_coordinate => 7
    @w_queen = Piece.create :game_id => id, :piece_type => "Queen", :piece_name => "w_queen", :piece_color => "white", :piece_status => "alive", :x_coordinate => 4, :y_coordinate => 7
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
                [@b_rook1, @b_knight1, @b_bishop1, @b_king, @b_queen, @b_bishop2, @b_knight2, @b_rook2],
                [@b_pawn1, @b_pawn2, @b_pawn3, @b_pawn4, @b_pawn5, @b_pawn6, @b_pawn7, @b_pawn8],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil],
                [@w_pawn1, @w_pawn2, @w_pawn3, @w_pawn4, @w_pawn5, @w_pawn6, @w_pawn7, @w_pawn8],
                [@w_rook1, @w_knight1, @w_bishop1, @w_king, @w_queen, @w_bishop2, @w_knight2, @w_rook2],
              ]
  end
end