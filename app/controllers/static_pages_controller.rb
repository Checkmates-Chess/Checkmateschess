class StaticPagesController < ApplicationController

  def home

  end

  def lobby
    @users = User.all
    @games = Game.available
  end

end
