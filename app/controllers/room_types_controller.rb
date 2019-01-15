class RoomTypesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @roomType = RoomType.find(params[:id])
  end

  def index
    @roomType = RoomType.all
  end

  def new
    @roomType = RoomType.new
  end

  def create
    @roomType = RoomType.new(params[:room_type])
    if @roomType.save
      flash[:success] = "NEW ROOM TYPE ADDED"
      redirect_to @roomType
    else
      render 'new'
    end
  end

  def update

  end
end
