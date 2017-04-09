class PiecesController < ApplicationController

	def create
		@piece = Piece.create(piece_params)
	end

	private

	def piece_params
		params.require(:piece).permit(:game_id, :piece_type, :piece_color, :piece_status, :x_coordinate, :y_coordinate)
	end
end
