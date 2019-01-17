class Gestion::ReservationsController < ApplicationController
  load_and_authorize_resource

  def index
    @reservation = Reservation.all
  end
end
