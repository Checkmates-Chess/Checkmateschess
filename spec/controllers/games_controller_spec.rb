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

      describe "creates the @board variable" do
        it "should place a Rook at board[0][0]" do
          expect(@game.board[0][0].piece_type).to eq("Rook")
        end
        it "should place w_rook2 at board[7][7]" do
          expect(@game.board[7][7].piece_name).to eq("w_rook2")
        end
        it "should place nothing (and have nil) at board[4][4]" do
          expect(@game.board[4][4]).to eq(nil)
        end
        it "should place w_king at board[7][4]" do
          expect(@game.board[7][4].piece_name).to eq("w_king")
        end
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
      white_pawn = game1.pieces.where(piece_type: "Pawn", piece_color: "white", x_coordinate: 0, y_coordinate: 6).first
      black_king = game1.pieces.where(piece_type: "King", piece_color: "black").first
      white_pawn.update_attributes(y_coordinate: 3, x_coordinate: 5)
      #white_pawn.x_coordinate = 5
      black_king.update_attributes(y_coordinate: 2, x_coordinate: 4)
      #black_king.x_coordinate = 4
      game1.board[6][0] = nil
      game1.board[0][4] = nil
      game1.board[3][5] = white_pawn
      game1.board[2][4] = black_king
      expect(game1.in_check?).to eq(true)
    end
  end

end

