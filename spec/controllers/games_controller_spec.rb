require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  after(:all) {User.destroy_all}
  describe "games#new" do
    it "should show new game page to signed in user" do
      user = FactoryGirl.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create" do
    it "should successfully create a game for signed in user" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, params: { 
        game: { 
          game_title: "best game 1" 
        } 
      }

      expect(response).to redirect_to root_path

      game = Game.last
      expect(game.game_title).to eq("best game 1")
      expect(game.user).to eq(user)
    end

    describe "create board" do
      it "should succesfully populate pieces" do
        user = FactoryGirl.create(:user)
        sign_in user

        game = FactoryGirl.create(:game)
        # checks if 32 pieces were created
        expect(Piece.all.count).to eq(32)
        # checks two specific pieces and whether they have the correct arguments assumed
        piece1 = Piece.find_by_piece_name("w_queen")
        piece2 = Piece.find_by_piece_name("b_rook1")        
        expect(piece1.y_coordinate).to eq(7)
        expect(piece2.x_coordinate).to eq(0)
      end

      it "should successfully create a board state" do
        user = FactoryGirl.create(:user)
        sign_in user

        game = FactoryGirl.create(:game)
        # check 4 different positions of the board
        expect(game.board[0][0].piece_type).to eq("Rook")
        expect(game.board[7][7].piece_name).to eq("w_rook2")
        expect(game.board[4][4]).to eq(nil)
        expect(game.board[7][4].piece_name).to eq("w_queen")
      end
    end
  end

  describe "games#show" do
    it "should show game" do
      game = FactoryGirl.create(:game)
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end
  end

  # describe "games#update" do
  #   it "should randomly assign current user id to player_black_id or player_white_id, nad joining player to the opposite" do
  #     game_to_join = FactoryGirl.create(:game)
  #     joining_user = FactoryGirl.create(:user, email: "derp@gmail.com", username: "derpman")
  #     sign_in joining_user
  #     patch :update, params: { id: game_to_join.id }
  #     game_to_join.reload
  #     expect(game_to_join.player_black_id).to eq joining_user.id
  #     expect(game_to_join.player_white_id).to eq game_to_join.user_id
  #   end
  # end
end

