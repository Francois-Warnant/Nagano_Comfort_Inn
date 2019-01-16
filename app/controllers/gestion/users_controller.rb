class Gestion::UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
  end

  def index
    @user = User.all
  end
end
