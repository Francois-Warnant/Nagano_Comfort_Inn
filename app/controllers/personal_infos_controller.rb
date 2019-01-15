class PersonalInfosController < ApplicationController

  before_filter :set_user

  def show
    @infos = PersonalInfo.find(params[:id])
  end

  def index
    @infos = PersonalInfo.all
  end

  def new
    @infos = PersonalInfo.new(user_id: @user.id)
  end

  def create
    @infos = current_user.build_personal_info(params[:personal_info])
    if @infos.save
      flash[:success] = "NEW INFOS ADDED"
      redirect_to @infos
    else
      render 'new'
    end
  end

  def update

  end

  def set_user
    @user = User.find(params[:user_id])
  end


end
