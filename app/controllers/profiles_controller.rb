class ProfilesController < ApplicationController
  before_filter :set_user

  def edit
    @user
  end

  def update
    # update code
  end

  def set_user
      @user = current_user
  end

end
