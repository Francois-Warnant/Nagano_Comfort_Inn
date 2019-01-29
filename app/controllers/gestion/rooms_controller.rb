module Gestion
  class RoomsController < Gestion::GestionController

    def show
      #@room = Room.find(params[:id])
    end

    def index
      @room = Room.view_types(1).room_types(1)
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
end