require 'rails_helper'

RSpec.describe GamesController, type: :controller do
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

        game.populate_game
        pieces = Piece.find_by_piece_name("b_rook1")

        #b_rook1 = Piece.find_by_piece_name("b_rook1")
        #b_rook1 = game.pieces.find_by_piece_name("b_rook1")
        expect(pieces.x_coordinate).to be(0)
        # expect(game.b_pawn1.y_coordinate).to be(1)
        # expect(game.w_rook1.x_coordinate).to be (0)
        # expect(game.w_rook1.piece_color).to eq("white")
        # expect(game.w_rook1.piece_type).to eq("Rook")
      end

      # it "should successfully create a board state" do
      #   user = FactoryGirl.create(:user)
      #   sign_in user

      #   post :create, params: {
      #     game: {
      #       game_title: "best game1"
      #     }
      #   }

      #   game = Game.last
      #   game.populate_game
      #   game.board_state
      #   expect(game.board).to eq([
      #                               [game.b_rook1, game.b_knight1, game.b_bishop1, game.b_king, game.b_queen, game.b_bishop2, game.b_knight2, game.b_rook2],
      #                               [game.b_pawn1, game.b_pawn2, game.b_pawn3, game.b_pawn4, game.b_pawn5, game.b_pawn6, game.b_pawn7, game.b_pawn8],
      #                               [nil, nil, nil, nil, nil, nil, nil, nil],
      #                               [nil, nil, nil, nil, nil, nil, nil, nil],
      #                               [nil, nil, nil, nil, nil, nil, nil, nil],
      #                               [nil, nil, nil, nil, nil, nil, nil, nil],
      #                               [game.w_pawn1, game.w_pawn2, game.w_pawn3, game.w_pawn4, game.w_pawn5, game.w_pawn6, game.w_pawn7, game.w_pawn8],
      #                               [game.w_rook1, game.w_knight1, game.w_bishop1, game.w_king, game.w_queen, game.w_bishop2, game.w_knight2, game.w_rook2]
      #         ])
      # end
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

