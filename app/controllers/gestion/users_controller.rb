module Gestion
	class UsersController < Gestion::GestionController

	  def show
	    @user = User.find(params[:id])
	  end

	  def index
	    @user = User.all
	  end
	end
end