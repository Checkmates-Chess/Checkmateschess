require 'rails_helper'
describe King do
  let(:game) { FactoryGirl.create(:game)}
  let(:pawn) do
    FactoryGirl.create(:piece, piece_type: "Pawn", game:game, user:game.user,
      x_coordinate: 1, y_coordinate: 2, piece_color: "white")

  end

  let(:king) do
      FactoryGirl.create(:piece, piece_type: "King", game:game, user:game.user,
      x_coordinate: 2, y_coordinate: 2, piece_color: "black")

  end

  describe "#checkmate?" do
    context "current game should not be checkmate" do
      it {expect(game.checkmate?(king.piece_color)).to eq(false)}
    end
  end


end
