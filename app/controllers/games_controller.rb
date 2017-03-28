class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def new
    @game = Game.new
  end

  def create
    Game.create(game_params)
    redirect_to root_path
  end

  def show
  end

  def update
    current_game.update_attributes(:player_black_id => current_user.id)
    redirect_to game_path(current_game)
  end

  private

  def game_params
    params.require(:game).permit(:game_title, :player_black_id, :player_white_id, :player_turn, :winner_id)
  end
end
