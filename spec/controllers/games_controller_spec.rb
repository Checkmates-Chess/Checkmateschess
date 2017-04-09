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
        puts game.board_state
        expect(game.board).to eq([
                                    [@b_rook, @b_knight1, @b_bishop1, @b_king, @b_queen, @b_bishop2, @b_knight2, @b_rook2],
                                    [@b_pawn1, @b_pawn2, @b_pawn3, @b_pawn4, @b_pawn5, @b_pawn6, @b_pawn7, @b_pawn8],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil, nil],
                                    [@w_pawn1, @w_pawn2, @w_pawn3, @w_pawn4, @w_pawn5, @w_pawn6, @w_pawn7, @w_pawn8],
                                    [@w_rook1, @w_knight1, @w_bishop1, @w_king, @w_queen, @w_bishop2, @w_knight2, @w_rook2]
              ])
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

  describe "games#update" do
    it "should assign current user id to player_black_id and host to player_white_id (for now) for open games" do
      game_to_join = FactoryGirl.create(:game)
      joining_user = FactoryGirl.create(:user, email: "derp@gmail.com", username: "derpman")
      sign_in joining_user
      patch :update, params: { id: game_to_join.id }
      game_to_join.reload
      expect(game_to_join.player_black_id).to eq joining_user.id
      expect(game_to_join.player_white_id).to eq game_to_join.user_id
    end
  end
end
