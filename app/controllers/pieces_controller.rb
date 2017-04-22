class PiecesController < ApplicationController
  before_action :find_game, only: :update
  before_action :find_piece, only: :update

	def create
		@piece = Piece.create(piece_params)
	end

  def update
    x_coordinate = @piece[:x_coordinate]
    y_coordinate = @piece[:y_coordinate]

    #move the piece
    if valid_movement?(@piece, x_coordinate,y_coordinate)
      @piece.move_to!(x_coordinate,y_coordinate)
      redirect_to  game_path(@game)
    else
      flash[:notice] = "That is not a valid move"
    end

  end

	private

	def piece_params
		params.require(:piece).permit(:game_id, :piece_type, :piece_color, :piece_status, :x_coordinate, :y_coordinate)
	end

  def find_game
    @game = current_user.games.find(params[:game_id])
  end

  def find_piece
    @piece = @game.pieces.find(params[:id])
  end

  def valid_movement?(piece, x_coordinate, y_coordinate)
    return true if piece.valid_move?(x_coordinate,y_coordinate)
  end
end


