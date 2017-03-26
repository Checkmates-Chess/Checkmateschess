class StaticPagesController < ApplicationController

  def home

  end

  def lobby
    @users = User.all
  end

end
