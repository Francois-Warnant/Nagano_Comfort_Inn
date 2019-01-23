module Gestion
  class ViewTypesController < Gestion::GestionController
    load_and_authorize_resource

    def show
      @view = ViewType.find(params[:id])
    end

    def index
      @view = ViewType.all
      respond_to do |format|

        format.html { }
        format.js
      end
    end

    def new
      @view = ViewType.new
      respond_to do |format|

        format.html { render "new" }
        format.js
      end
    end

    def create
      @view = ViewType.new(params[:view_type])
      if @view.save

        flash[:success] = "NEW VIEW ADDED"
        redirect_to gestion_view_types_path
      else
        render 'new'
      end
    end

    def update

    end
  end
end