class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)  
    if rand(2) == 0
      @game.update_attributes(player_white_id: @game.user_id)
    else 
      @game.update_attributes(player_black_id: @game.user_id)
    end
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.player_black_id.nil?
      @game.update_attributes(:player_black_id => current_user.id)
    elsif @game.player_white_id.nil?
      @game.update_attributes(:player_white_id => current_user.id)
    end
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:game_title, :player_black_id, :player_white_id, :player_turn, :winner_id)
  end
end
