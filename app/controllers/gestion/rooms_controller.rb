module Gestion
  class RoomsController < Gestion::GestionController

    def show
      #@room = Room.find(params[:id])
    end

    def index
      @rooms = Room.paginate(page: params[:page])
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