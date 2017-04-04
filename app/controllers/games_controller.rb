class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @game = Game.new
  end

  def create
    current_user.games.create(game_params)
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(:player_black_id => current_user.id, :player_white_id => @game.user_id)
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:game_title, :player_black_id, :player_white_id, :player_turn, :winner_id)
  end
end
