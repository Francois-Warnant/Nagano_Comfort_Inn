module Gestion
  class RoomTypesController < Gestion::GestionController

    def show
      @roomType = RoomType.find(params[:id])
    end

    def index
      @roomTypes = RoomType.all
      @roomType = RoomType.new

      respond_to do |format|
        format.html { }
        format.js
      end
    end

    def new
      @roomType = RoomType.new
    end

    def create
      @roomType = RoomType.new(params[:room_type])

      respond_to do |format|
        if @roomType.save
          #flash[:success] = "NEW ROOM ADDED"
          format.html { redirect_to gestion_room_types_path, notice: "NEW ROOM ADDED" }
          format.js { render partial: "create" }
        else
          format.html { render 'new' }
        end
      end
    end

    def update

    end
  end
end