class PiecesController < ApplicationController
  before_action :authenticate_user!

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
    @piece.update_attributes(piece_params)
    redirect_to piece_path(@piece)
  end

	private

	def piece_params
		params.require(:piece).permit(:x_coordinate, :y_coordinate)
	end
end
