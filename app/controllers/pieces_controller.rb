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
    enemy_color = color == "white" ? "black" : "white"
    new_x = params[:piece][:x_coordinate]
    new_y = params[:piece][:y_coordinate]
    valid_move = @piece.valid_move?(new_y, new_x)
    remove_flag = false
    in_check = false
    pawn_promotion = false
    stalemate = false
    checkmate = false
    pawn_promote_status = params[:piece][:piece_status]

    castled_rook_x = nil
    castle_flag = false

    # castle flag
    if @piece.piece_type == "King"
      if @piece.castle_valid_move?(new_y, new_x)
        castle_flag = true
      end
    end

    # establish in check, stalemate, checkmate by updating to new position and checking, then updating back
    @piece.update_attributes(x_coordinate: new_x, y_coordinate: new_y)
      in_check = @game.side_in_check?(color)
      stalemate = @game.stalemate?
      checkmate = @game.checkmate?(enemy_color)
    @piece.update_attributes(x_coordinate: old_x, y_coordinate: old_y)
  

    # check for checkmate or stalemate
    if stalemate || checkmate
      remove_flag = @piece.move_to!(new_y, new_x)
    # check for pawn promotion 
    elsif !pawn_promote_status.nil?
      if pawn_promote_status.include?("promote to")
        if pawn_promote_status.include?("promote to rook")
          @piece.update_attributes(piece_type: "Rook", piece_status: "alive|promoted pawn")
          if color == "black"
            @piece.update_attributes(piece_name: "b_rook1")
          else
            @piece.update_attributes(piece_name: "w_rook1")
          end
        elsif pawn_promote_status.include?("promote to bishop")
          @piece.update_attributes(piece_type: "Bishop", piece_status: "alive|promoted pawn")
          if color == "black"
            @piece.update_attributes(piece_name: "b_bishop1")
          else
            @piece.update_attributes(piece_name: "w_bishop1")
          end
        elsif pawn_promote_status.include?("promote to knight")
          @piece.update_attributes(piece_type: "Knight", piece_status: "alive|promoted pawn")
          if color == "black"
            @piece.update_attributes(piece_name: "b_knight1")
          else
            @piece.update_attributes(piece_name: "w_knight1")
          end
        else
          @piece.update_attributes(piece_type: "Queen", piece_status: "alive|promoted pawn")
          if color == "black"
            @piece.update_attributes(piece_name: "b_queen")
          else
            @piece.update_attributes(piece_name: "w_queen")
          end
        end
      end
    elsif castle_flag
      @piece.castle_move!(new_y, new_x)
      @game.switch_turn
    # checking for allowed move and update piece      
    elsif valid_move
      if !in_check
        remove_flag = @piece.move_to!(new_y, new_x)
        @game.switch_turn
      end
    end

    json_piece = {
      x_coordinate: @piece.x_coordinate,
      y_coordinate: @piece.y_coordinate,
      remove_flag: remove_flag,
      pawn_promotion: pawn_promotion,
      old_x: old_x,
      old_y: old_y,
      color: color,
      piece_type: @piece.piece_type,
      piece_name: @piece.piece_name,
      castle_flag: castle_flag,
      stalemate: stalemate,
      checkmate: checkmate,
      new_x: new_x,
      new_y: new_y,
      valid_move: valid_move,
      player_turn: @game.player_turn,
      in_check: in_check
      }
    render json: json_piece
  end

	private

	def piece_params
		params.require(:piece).permit(:game_id, :piece_type, :piece_name, :piece_color, :piece_status, :x_coordinate, :y_coordinate)
	end
end
