class PiecesController < ApplicationController

	def create
		@game = current_user.games.find(params[:id])
		@piece = @game.pieces.create(piece_params)
	end

	private

	def piece_params
		params.require(:piece).permit(:game_id, :piece_type, :piece_name, :piece_color, :piece_status, :x_coordinate, :y_coordinate)
	end
end
