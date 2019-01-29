module Gestion
  class ViewTypesController < GestionController

    def show
      @view = ViewType.find(params[:id])
    end

    def index
      @views = ViewType.all
      @view = ViewType.new

      respond_to do |format|
        format.html { }
        format.js
      end
    end

    def new
      @view = ViewType.new

      respond_to do |format|
        format.html { render "new" }
        format.js { render partial: "new" }
      end
    end

    def create
      @view = ViewType.new(params[:view_type])

      respond_to do |format|
        if @view.save
          format.html { redirect_to gestion_view_types_path, notice: "NEW VIEW ADDED" }
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