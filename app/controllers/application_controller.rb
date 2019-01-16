class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, except: [:home, :login, :sign_up]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    current_user_has_reservations = current_user.reservations.count > 0

    if  current_user_has_reservations
      current_user
    else
      new_reservation_path
    end
  end

  def signed_in_user
    redirect_to new_user_session_path, notice: "Please sign in." unless signed_in?
  end

  protect_from_forgery
end
