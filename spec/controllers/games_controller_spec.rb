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
  end

  describe "games#show" do
    it "should show game" do
      game = FactoryGirl.create(:game)
      get :show, params: { id: game.id }
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
end
