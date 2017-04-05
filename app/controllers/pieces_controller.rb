class PiecesController < ApplicationController
  before_action :authenticate_user!
  #def new
  #  @piece = Piece.new
  #  @pieces = Piece.all
  #end

	#def create
	#	 @piece = Piece.new
  #  @piece.update_attributes(piece_params)
  #  @piece.update_attributes(:piece_type => "Bishop", :piece_color => "black", :x_coordinate => 5, :y_coordinate => 5)
  #  @piece.piece_type = "Bishop"
  #  @piece.piece_color = "black"
  #  @piece.x_coordinate = 5
  #  @piece.y_coordinate = 5
  #  @piece.user = current_user
  #  @piece.save
	#end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
    @piece.update_attributes(piece_params)
    redirect_to game_path(@piece.game)
  end

	private

	def piece_params
		params.require(:piece).permit(:x_coordinate, :y_coordinate)
	end
end
