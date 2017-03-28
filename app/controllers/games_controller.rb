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
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
