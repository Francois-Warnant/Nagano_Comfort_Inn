class ViewTypesController < ApplicationController
  def show
    @view = ViewType.find(params[:id])
  end

  def index
    @view = ViewType.all
  end

  def new
    @view = ViewType.new
  end

  def create
    @view = ViewType.new(params[:view_type])
    if @view.save
      flash[:success] = "NEW VIEW ADDED"
      redirect_to @view
    else
      render 'new'
    end
  end

  def update

  end
end
