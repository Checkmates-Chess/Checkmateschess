require 'rails_helper'
RSpec.describe Game, type: :model do
  before(:each) do
     @user = FactoryGirl.create(:user)
     @game = FactoryGirl.create(:game)
     #@knight = Piece.create(piece_type: "Knight", x_coordinate: 1,y_coordinate: 0, piece_color: "white", game: @game, user: @user)
     @king = Piece.create(piece_type: "King", x_coordinate: 2,y_coordinate: 2, piece_color: "black", game: @game)
   end

   describe "#switch_turn" do
     it "should update player_turn" do
       expect(@game.switch_turn(@king.game.player_turn)).to eq(true)
     end
   end

end
