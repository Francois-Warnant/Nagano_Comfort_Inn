class ReservationsController < ApplicationController
  def show
    @reservation = Reservation.find(params[:id])
  end

  def index
    @reservation = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    if @reservation.save
      flash[:success] = "NEW RESERVATION ADDED"
      redirect_to @reservation
    else
      render 'new'
    end
  end

  def update

  end
end
