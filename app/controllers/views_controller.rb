class ViewsController < ApplicationController
  def show
    @view = Views.find(params[:id])
  end

  def index
    @view = Views.all
  end

  def new
    @view = Views.new
  end

  def create
    @view = Views.new(params[:views])
    if @view.save
      flash[:success] = "NEW VIEWS ADDED"
      redirect_to @view
    else
      render 'new'
    end
  end

  def update

  end
end
