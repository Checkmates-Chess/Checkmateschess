class PiecesController < ApplicationController

	def create
		@piece = Piece.create(piece_params)
	end

  def update
    @game = current_user.games.find(params[:game_id])
    @piece = @game.pieces.find(params[:id])
    x_coordinate = @piece[:x_coordinate]
    y_coordinate = @piece[:y_coordinate]

    #move the piece
    valid_movement = @piece.move_to!(x_coordinate, y_coordinate)
    if !valid_movement
      flash[:notice] = "That is not a valid move"
    else
      valid_movement
    end



    #@piece.move_to!(params[:x_coordinate], params[:y_coordinate])
  end

	private

	def piece_params
		params.require(:piece).permit(:game_id, :piece_type, :piece_color, :piece_status, :x_coordinate, :y_coordinate)
	end
end


# PUT /pieces/:id, remote: true
# body


# /games/:game_id/pieces/:id
# body


# ajx.body: { 'x': 1, 'y': 2, 'game_id': 1}

# update.js.erb

# #

# board.html.erb
