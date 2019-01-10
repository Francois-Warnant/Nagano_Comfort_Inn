class Reservation < ActiveRecord::Base
  attr_accessible :client_demands, :end_date, :start_date, :user_id
end
