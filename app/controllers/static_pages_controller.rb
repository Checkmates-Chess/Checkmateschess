class StaticPagesController < ApplicationController

  def home

  end

  def lobby
    @users = User.all
  end

  def board
  end

end
