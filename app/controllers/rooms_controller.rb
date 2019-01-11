class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
  end

  def index
    @room = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      flash[:success] = "NEW ROOM ADDED"
      redirect_to @room
    else
      render 'new'
    end
  end

  def update

  end
end
