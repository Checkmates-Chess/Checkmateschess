require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @game = FactoryGirl.create(:game)
  end

  before(:each) {sign_in @user}
  after(:all) {User.destroy_all}

  describe "games#new" do
    it "should show new game page to signed in user" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create" do
    it "should successfully create a game for signed in user" do
      post :create, params: { 
        game: { 
          game_title: "best game 1" 
        } 
      }

      expect(response).to redirect_to root_path

      game = Game.last
      expect(game.game_title).to eq("best game 1")
      expect(game.user).to eq(@user)
    end

    describe "populate_game method" do
      it "should succesfully create 32 pieces" do
        expect(Piece.all.count).to eq(32)
      end

      describe "create pieces with their correct attributes" do
        it "should successfully create w_queen with y_coordinate of 7" do
          piece1 = Piece.find_by_piece_name("w_queen")
          expect(piece1.y_coordinate).to eq(7)
        end
        it "should successfully create b_rook1 with x_coordinate of 0" do
          piece2 = Piece.find_by_piece_name("b_rook1")                  
          expect(piece2.x_coordinate).to eq(0)
        end
      end
    end

    describe "create board" do
      it "should succesfully populate pieces" do
        user = FactoryGirl.create(:user)
        sign_in user

        post :create, params: {
          game: {
            game_title: "best game1"
          }
        }

        game = Game.last
        game.populate_game
        expect(game.b_pawn1.x_coordinate).to be(1)
        expect(game.b_pawn1.y_coordinate).to be(1)
        expect(game.w_rook1.x_coordinate).to be (0)
        expect(game.w_rook1.piece_color).to eq("white")
        #why doesn't piece_type get set to rook?
        expect(game.w_rook1.piece_type).to eq("Rook")
      end

      it "should successfully create a board state" do
        user = FactoryGirl.create(:user)
        sign_in user

        post :create, params: {
          game: {
            game_title: "best game1"
          }
        }

        game = Game.last
        game.populate_game
        game.board_state
        expect(game.board).to eq([
                                    [game.b_rook1, game.b_knight1, game.b_bishop1, game.b_king, game.b_queen, game.b_bishop2, game.b_knight2, game.b_rook2],
                                    [game.b_pawn1, game.b_pawn2, game.b_pawn3, game.b_pawn4, game.b_pawn5, game.b_pawn6, game.b_pawn7, game.b_pawn8],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [game.w_pawn1, game.w_pawn2, game.w_pawn3, game.w_pawn4, game.w_pawn5, game.w_pawn6, game.w_pawn7, game.w_pawn8],
                                    [game.w_rook1, game.w_knight1, game.w_bishop1, game.w_king, game.w_queen, game.w_bishop2, game.w_knight2, game.w_rook2]
              ])
      end
    end
  end

  describe "games#show" do
    it "should show game" do
      get :show, params: { id: @game.id }
      expect(response).to have_http_status(:success)
    end
  end

  # describe "games#update" do
  #   it "should randomly assign current user id to player_black_id or player_white_id, and joining player to the opposite" do
  #     game_to_join = FactoryGirl.create(:game)
  #     joining_user = FactoryGirl.create(:user)
  #     sign_in joining_user
  #     patch :update, params: { id: game_to_join.id }
  #     game_to_join.reload
  #     expect(game_to_join.player_black_id).to eq joining_user.id
  #     expect(game_to_join.player_white_id).to eq game_to_join.user_id
  #   end
  # end

  describe "in check method" do
    it "should return true for black king in check from white pawn" do 
      game1 = FactoryGirl.create(:game)
      game1.player_turn = "white"
      white_pawn = game1.pieces.where(piece_type: "Pawn", piece_color: "white", x_coordinate: 0, y_coordinate: 6).first
      black_king = game1.pieces.where(piece_type: "King", piece_color: "black").first
      white_pawn.update_attributes(y_coordinate: 3, x_coordinate: 5)
      black_king.update_attributes(y_coordinate: 2, x_coordinate: 4)
      
      expect(game1.side_in_check?("black")).to eq(true)
    end

    it "should return true for black king in check from white bishop" do
      game1 = FactoryGirl.create(:game)
      game1.player_turn = "white"
      white_bishop = game1.pieces.where(piece_type: "Bishop", piece_color: "white", x_coordinate: 2, y_coordinate: 7).first
      black_king = game1.pieces.where(piece_type: "King", piece_color: "black").first
      white_bishop.update_attributes(y_coordinate: 5, x_coordinate: 1)
      black_king.update_attributes(y_coordinate: 2, x_coordinate: 4)
      
      expect(game1.side_in_check?("black")).to eq(true)  
    end

    it "should return true for black king in check from white rook" do
      game1 = FactoryGirl.create(:game)
      game1.player_turn = "white"
      white_rook = game1.pieces.where(piece_type: "Rook", piece_color: "white", x_coordinate: 0, y_coordinate: 7).first
      black_king = game1.pieces.where(piece_type: "King", piece_color: "black").first
      white_rook.update_attributes(y_coordinate: 2, x_coordinate: 7)
      black_king.update_attributes(y_coordinate: 2, x_coordinate: 4)
      
      expect(game1.side_in_check?("black")).to eq(true)  
    end

    it "should return true for white king in check from black pawn" do
      game1 = FactoryGirl.create(:game)
      game1.player_turn = "black"
      black_pawn = game1.pieces.where(piece_type: "Pawn", piece_color: "black", x_coordinate: 0, y_coordinate: 1).first
      white_king = game1.pieces.where(piece_type: "King", piece_color: "white").first
      black_pawn.update_attributes(y_coordinate: 4, x_coordinate: 3)
      white_king.update_attributes(y_coordinate: 5, x_coordinate: 4)
      
      expect(game1.side_in_check?("white")).to eq(true)  
    end

    it "should return true for white king in check from black bishop" do
      game1 = FactoryGirl.create(:game)
      game1.player_turn = "black"
      black_bishop = game1.pieces.where(piece_type: "Bishop", piece_color: "black", x_coordinate: 2, y_coordinate: 0).first
      white_king = game1.pieces.where(piece_type: "King", piece_color: "white").first
      black_bishop.update_attributes(y_coordinate: 2, x_coordinate: 1)
      white_king.update_attributes(y_coordinate: 5, x_coordinate: 4)
     
      expect(game1.side_in_check?("white")).to eq(true)  
    end

    it "should return true for white king in check from black rook" do
      game1 = FactoryGirl.create(:game)
      game1.player_turn = "black"
      black_rook = game1.pieces.where(piece_type: "Rook", piece_color: "black", x_coordinate: 0, y_coordinate: 0).first
      white_king = game1.pieces.where(piece_type: "King", piece_color: "white").first
      black_rook.update_attributes(y_coordinate: 2, x_coordinate: 4)
      white_king.update_attributes(y_coordinate: 5, x_coordinate: 4)
      
      expect(game1.side_in_check?("white")).to eq(true)  
    end

    it "should return false for beginning board state" do
      game1 = FactoryGirl.create(:game)
      expect(game1.side_in_check?("black")).to eq(false) 
    end

    it "should return false for black king not in check from white rook" do
      game1 = FactoryGirl.create(:game)
      game1.player_turn = "white"
      white_rook = game1.pieces.where(piece_type: "Rook", piece_color: "white", x_coordinate: 0, y_coordinate: 7).first
      black_king = game1.pieces.where(piece_type: "King", piece_color: "black").first
      white_rook.update_attributes(y_coordinate: 3, x_coordinate: 5)
      black_king.update_attributes(y_coordinate: 2, x_coordinate: 4)
      
      expect(game1.in_check?).to eq(false)  
    end
  end

end

