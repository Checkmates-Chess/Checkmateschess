require 'rails_helper'

RSpec.describe Pawn, type: :model do
  before(:each) do
    @game = FactoryGirl.create(:game)
    @pawn = @game.pieces.create(x_coordinate: 7, y_coordinate: 7, piece_type: "Pawn",game: @game, piece_color: "white")
    @pawn2 = @game.pieces.create(x_coordinate: 0, y_coordinate: 0, piece_type: "Pawn", game: @game, piece_color: "black")
    @pawn3 = @game.pieces.create(x_coordinate: 6, y_coordinate: 6, piece_type: "Pawn", game: @game, piece_color: "white")
  end

  describe "can promote?" do
    it "should show a pawn can promote" do
      expect(@pawn.can_promote(@pawn.y_coordinate)).to eq(true)
      expect(@pawn2.can_promote(@pawn2.y_coordinate)).to eq(true)
    end
  end

  describe "promotion of piece" do
    it "should update a pawn to a chosen piece" do
      @pawn.promotion(@pawn,"Queen")
      @pawn2.promotion(@pawn2, "Rook")
      expect(@pawn.piece_type).to eq("Queen")
      expect(@pawn2.piece_type).to eq("Rook")
    end

    it "should not update a pawn that is not in a valid rank" do
      expect(@pawn3.can_promote(@pawn3.y_coordinate)).to eq(false)
    end
  end


end
