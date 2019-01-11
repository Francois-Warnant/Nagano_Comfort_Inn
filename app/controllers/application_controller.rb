class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    current_user
  end

  protect_from_forgery
end
