require 'rails_helper'
RSpec.describe King do
  # let(:game) { FactoryGirl.create(:game)}
  # let(:pawn) do
  #   FactoryGirl.create(:piece, piece_type: "Pawn", game:game, user:game.user,
  #     x_coordinate: 1, y_coordinate: 2, piece_color: "white")

  # end

  # let(:king) do
  #     FactoryGirl.create(:piece, piece_type: "King", game:game, user:game.user,
  #     x_coordinate: 2, y_coordinate: 2, piece_color: "black")
  # end

  # let(:knight) do
  #     FactoryGirl.create(:piece, piece_type: "Knight", game:game, user:game.user,
  #     x_coordinate: 1, y_coordinate: 0, piece_color: "white")

  # end

  before(:each) do
    @user = FactoryGirl.create(:user)
    @game = FactoryGirl.create(:game)
    @knight = Piece.create(piece_type: "Knight", x_coordinate: 1,y_coordinate: 0, piece_color: "white", game: @game, user: @user)
    @king = Piece.create(piece_type: "King", x_coordinate: 2,y_coordinate: 2, piece_color: "black", game: @game, user:@user)
  end

  after(:all) do
    User.destroy_all
  end

  describe "#move_out_of_check?" do
    context "king should be able to move out of check" do
      it{
        expect(@king.move_out_of_check?).to eq(true)
      }
    end

    context "#side_in_check with a piece checking king" do
      it{
        expect(@game.side_in_check?(@king.piece_color)).to eq(true)
      }
    end

    context "#side_in_check without a piece checking king" do
      it{
        @knight.update_attributes(x_coordinate:0, y_coordinate:0)
        @knight.reload
        expect(@game.side_in_check?(@king.piece_color)).to eq(false)
      }
    end

    context "#checkmate? with a king that can run away" do
      it{expect(@game.checkmate?(@king.piece_color)).to eq(false)}
    end

    context "#checkmate? with a king that CAN'T run away" do
      it{

        @bishop = Piece.create(piece_type: "Bishop", piece_color: "white", x_coordinate: 1,y_coordinate: 3, game: @game1, user: @user)
        @blackPawn1 = Piece.create(piece_type: "Pawn", piece_color: "white", x_coordinate: 3,y_coordinate: 3, game: @game1, user: @user)
        @blackPawn2 = Piece.create(piece_type: "Pawn", piece_color: "white", x_coordinate: 3,y_coordinate: 2, game: @game1, user: @user)
        @blackPawn3 = Piece.create(piece_type: "Pawn", piece_color: "white", x_coordinate: 3,y_coordinate: 1, game: @game1, user: @user)
        @blackPawn4 = Piece.create(piece_type: "Pawn", piece_color: "white", x_coordinate: 2,y_coordinate: 3, game: @game1, user: @user)
        @blackPawn5 = Piece.create(piece_type: "Pawn", piece_color: "white", x_coordinate: 2,y_coordinate: 1, game: @game1, user: @user)
        @blackPawn6 = Piece.create(piece_type: "Pawn", piece_color: "white", x_coordinate: 1,y_coordinate: 2, game: @game1, user: @user)
        @blackPawn67= Piece.create(piece_type: "Pawn", piece_color: "white", x_coordinate: 1,y_coordinate: 1, game: @game1, user: @user)
        expect(@game.checkmate?(@king.piece_color)).to eq(true)
      }
    end

  end
end
