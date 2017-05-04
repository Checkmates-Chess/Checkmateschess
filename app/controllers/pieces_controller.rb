class PiecesController < ApplicationController
  before_action :authenticate_user!

  def create
		@game = current_user.games.find(params[:id])
		@piece = @game.pieces.create(piece_params)
	end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    old_x = @piece.x_coordinate
    old_y = @piece.y_coordinate
    color = @piece.piece_color
    new_x = params[:piece][:x_coordinate]
    new_y = params[:piece][:y_coordinate]
    valid_move = @piece.valid_move?(new_y, new_x)
    remove_flag = false
    in_check = false
    pawn_promotion = false
    piece_type = @piece.piece_type

    # checking for allowed move and updating piece
    if valid_move
      @piece.update_attributes(x_coordinate: new_x, y_coordinate: new_y)
      in_check = @game.side_in_check?(color)
      @piece.update_attributes(x_coordinate: old_x, y_coordinate: old_y)
      if !in_check
        remove_flag = @piece.move_to!(new_y, new_x)
        @game.switch_turn
      end
    end

    pawn_promotion = @piece.pawn_promotion?(new_y, new_x)

    json_piece = {
      x_coordinate: @piece.x_coordinate,
      y_coordinate: @piece.y_coordinate,
      remove_flag: remove_flag,
      pawn_promotion: pawn_promotion,
      old_x: old_x,
      old_y: old_y,
      color: color,
      piece_type: piece_type
    }
    render json: json_piece
  end

	private

	def piece_params
		params.require(:piece).permit(:game_id, :piece_type, :piece_name, :piece_color, :piece_status, :x_coordinate, :y_coordinate)
	end
end
