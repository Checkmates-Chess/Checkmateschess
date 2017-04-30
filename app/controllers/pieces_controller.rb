class PiecesController < ApplicationController
  before_action :authenticate_user!

  def create
		@game = current_user.games.find(params[:id])
		@piece = @game.pieces.create(piece_params)
	end

	def show
    @piece = Piece.find(params[:id])
    current_piece_status = @piece.piece_status
    if current_piece_status.nil?
      @piece.update_attributes(piece_status: "highlighted")
    else
      @piece.update_attributes(piece_status: current_piece_status + "|highlighted")
    end
    redirect_to game_path(@piece.game)
  end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    old_x = @piece.x_coordinate
    old_y = @piece.y_coordinate
    color = @piece.piece_color
    new_x = params[:piece][:x_coordinate]
    new_y = params[:piece][:y_coordinate]
    valid_move = @piece.valid_move?(new_y.to_i, new_x.to_i)
    in_check = nil
    board = [[], [], [], [], [], [], [], []]
    8.times do |row|
      8.times do |col|
        board_piece = @game.pieces.where(x_coordinate: col, y_coordinate: row).first
        board[row][col] = board_piece
      end
    end
    is_obstructed = @piece.is_obstructed?(board, old_y.to_i, old_x.to_i, new_y.to_i, new_x.to_i)
    if valid_move
      @piece.update_attributes(piece_params)
      status = @piece.piece_status
      if status.include?("first move")
        status.sub! "|first move", ""
        @piece.update_attributes(piece_status: status)
      end
      in_check = @game.side_in_check?(color)
      if in_check
        @piece.update_attributes(x_coordinate: old_x, y_coordinate: old_y)
      end
    end
    json_piece = {
      x_coordinate: @piece.x_coordinate,
      y_coordinate: @piece.y_coordinate,
      passed_x: new_x,
      passed_y: new_y,
      valid_move: valid_move, 
      in_check: in_check,
      is_obstructed: is_obstructed,
      piece_status: @piece.piece_status
    }
    render json: json_piece
  end

	private

	def piece_params
		params.require(:piece).permit(:game_id, :piece_type, :piece_name, :piece_color, :piece_status, :x_coordinate, :y_coordinate)
	end
end
