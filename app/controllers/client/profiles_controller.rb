class Client::ProfilesController < Client::ClientController

  before_filter :set_user

  def edit

  end

  def update
    # update code
  end

  private
    def set_user # duplicate // should be centralized
        @user = current_user
    end
end
