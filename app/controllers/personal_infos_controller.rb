class PersonalInfosController < ApplicationController
  def show
    @infos = PersonalInfo.find(params[:id])
  end

  def index
    @infos = PersonalInfo.all
  end

  def new
    @infos = PersonalInfo.new
  end

  def create
    @infos = PersonalInfo.new(params[:personal_info])
    if @infos.save
      flash[:success] = "NEW INFOS ADDED"
      redirect_to @infos
    else
      render 'new'
    end
  end

  def update

  end
end
